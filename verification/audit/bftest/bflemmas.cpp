// Parallel sound brute force for P(2,N) (standard-form networks, M -> N-1, m -> N-2).
// Same search as p2sym3.cpp: no commuting-order rule; untouched-channel symmetry; lb + lb2 (valid lower bounds);
// failed-state memo keyed on the full state (128-bit hash), shared across threads (sharded).
// huff(v) computed exactly as ceil(log2(sum 2^v_i)) (minimax-tree / Kraft identity for integer weights).
#include <bits/stdc++.h>
using namespace std;
int N, L;
struct St { uint8_t pM[16]; uint8_t pm[16][16]; uint8_t cost[16][16]; };
struct H128{ uint64_t a,b; bool operator==(const H128&o) const {return a==o.a&&b==o.b;} };
struct HH{ size_t operator()(const H128&h) const { return h.a^(h.b*0x9E3779B97F4A7C15ULL); } };
const int NSH=4096;
// lossy set-associative cache per shard: fixed size, 4-way buckets, replacement by rotating victim (a cache is always sound)
struct Shard { mutex mu; vector<H128> t; size_t nb=0; uint32_t rot=0;
  void init(size_t buckets){ nb=buckets; t.assign(nb*4,H128{0,0}); }
  bool has(const H128&h){ size_t bk=(h.b^(h.a>>17))%nb; H128* p=&t[bk*4]; for(int i=0;i<4;i++) if(p[i]==h) return true; return false; }
  bool add(const H128&h){ size_t bk=(h.b^(h.a>>17))%nb; H128* p=&t[bk*4]; for(int i=0;i<4;i++){ if(p[i]==h) return false; if(p[i].a==0&&p[i].b==0){ p[i]=h; return true; } } p[(rot++)&3]=h; return true; }
};
Shard* shards; long long memoCap=LLONG_MAX;
atomic<long long> gmemo(0);
struct alignas(64) PadCnt { long long v=0; char pad[56]; };
PadCnt tcnt[256], tmemo[256]; thread_local int tid=0;
long long totalMemo(){ long long s=0; for(int i=0;i<256;i++) s+=tmemo[i].v; return s; }
long long totalNodes(){ long long s=0; for(int i=0;i<256;i++) s+=tcnt[i].v; return s; }
atomic<bool> found(false);
H128 hashSt(const St&s){
  uint64_t h=1469598103934665603ULL, g=0x243F6A8885A308D3ULL;
  auto mix=[&](uint64_t v){ h^=v; h*=1099511628211ULL; g+=v+0x9E3779B97F4A7C15ULL; g^=g>>29; g*=0xBF58476D1CE4E5B9ULL; g^=g>>32; };
  for(int x=0;x<N;x++){ mix(s.pM[x]); for(int y=0;y<N;y++) if(y!=x){ mix(s.pm[x][y]); mix(s.cost[x][y]); } }
  if(h==0&&g==0) g=1;
  return H128{h,g};
}
// ---- canonicalization under (sigma in Sym(N) on input labels) x (pi in Sym(channels) fixing N-1, N-2) ----
// Feasibility of a state is invariant under both (relabel runs; relabel channels + untangle the continuation:
// run (N-1,N-2) keeps M at N-1 and m at N-2, which pins the outputs). Any deterministic choice of (sigma,pi) is sound.
static inline uint64_t mix64(uint64_t z){ z+=0x9E3779B97F4A7C15ULL; z=(z^(z>>30))*0xBF58476D1CE4E5B9ULL; z=(z^(z>>27))*0x94D049BB133111EBULL; return z^(z>>31); }
int CANON=1, CROUNDS=3;
H128 canonHash(const St& s){
  if(!CANON) return hashSt(s);
  uint64_t cx[16], cc[16], ncx[16], ncc[16];
  for(int x=0;x<N;x++) cx[x]=1;
  for(int c=0;c<N;c++) cc[c]= (c==N-1)?1001:(c==N-2)?1002:7;
  uint64_t items[300];
  for(int r=0;r<CROUNDS;r++){
    for(int c=0;c<N;c++){ int k=0;
      for(int x=0;x<N;x++){ if(s.pM[x]==c) items[k++]=mix64(1000003ULL*cx[x]+1);
        for(int y=0;y<N;y++) if(y!=x && s.pm[x][y]==c) items[k++]=mix64(mix64(cx[x]*31+cx[y])*7+s.cost[x][y]+2); }
      sort(items,items+k); uint64_t h=mix64(cc[c]); for(int i=0;i<k;i++) h=mix64(h^items[i]); ncc[c]=h; }
    for(int x=0;x<N;x++){ int k=0;
      items[k++]=mix64(ncc[s.pM[x]]*3+3);
      for(int y=0;y<N;y++) if(y!=x){ items[k++]=mix64(mix64(cx[y]*131+ncc[s.pm[x][y]])*11+s.cost[x][y]+4); items[k++]=mix64(mix64(cx[y]*137+ncc[s.pm[y][x]])*13+s.cost[y][x]+5); }
      sort(items,items+k); uint64_t h=mix64(cx[x]+17); for(int i=0;i<k;i++) h=mix64(h^items[i]); ncx[x]=h; }
    memcpy(cc,ncc,sizeof(cc)); memcpy(cx,ncx,sizeof(cx));
  }
  int ox[16], oc[16]; for(int i=0;i<N;i++){ ox[i]=i; }
  sort(ox,ox+N,[&](int a,int b){ return cx[a]!=cx[b] ? cx[a]<cx[b] : a<b; });
  int rx[16]; for(int i=0;i<N;i++) rx[ox[i]]=i;
  int m=0; for(int c=0;c<N-2;c++) oc[m++]=c;
  sort(oc,oc+m,[&](int a,int b){ return cc[a]!=cc[b] ? cc[a]<cc[b] : a<b; });
  int rc[16]; for(int i=0;i<m;i++) rc[oc[i]]=i; rc[N-2]=N-2; rc[N-1]=N-1;
  St t; memset(&t,0,sizeof t);
  for(int x=0;x<N;x++){ t.pM[rx[x]]=rc[s.pM[x]]; for(int y=0;y<N;y++) if(y!=x){ t.pm[rx[x]][rx[y]]=rc[s.pm[x][y]]; t.cost[rx[x]][rx[y]]=s.cost[x][y]; } }
  return hashSt(t);
}
bool memoHas(const H128&h){ Shard& sh=shards[h.a%NSH]; lock_guard<mutex> lk(sh.mu); return sh.has(h); }
void memoAdd(const H128&h){ Shard& sh=shards[h.a%NSH]; lock_guard<mutex> lk(sh.mu); if(sh.add(h)) tmemo[tid].v++; }
static inline int huffSum(uint64_t S){ // ceil(log2 S), S>=1
  if(S<=1) return 0; return 64-__builtin_clzll(S-1); }
int lb(const St&s){
  int best=0;
  { uint64_t S=0; int cnt=0,lastc=-1; int val[16]; for(int c=0;c<N;c++) val[c]=-1;
    for(int x=0;x<N;x++){ int mx=0; for(int y=0;y<N;y++) if(y!=x) mx=max(mx,(int)s.cost[x][y]); int c=s.pM[x]; val[c]=max(val[c],mx);}
    int v0=0; for(int c=0;c<N;c++) if(val[c]>=0){ S+=1ULL<<val[c]; cnt++; lastc=c; v0=val[c]; }
    int h=huffSum(S); if(cnt==1 && lastc!=N-1) h=v0+1; best=max(best,h); }
  for(int x=0;x<N;x++){
    int vv[16]; for(int c=0;c<N;c++) vv[c]=-1;
    for(int y=0;y<N;y++) if(y!=x){int c=s.pm[x][y]; vv[c]=max(vv[c],(int)s.cost[x][y]);}
    uint64_t S=0; int k=0,lc=-1,w0=0; for(int c=0;c<N;c++) if(vv[c]>=0){ S+=1ULL<<vv[c]; k++; lc=c; w0=vv[c]; }
    int g=huffSum(S); if(k==1 && lc!=N-2) g=w0+1; best=max(best,g);
  }
  return best;
}
int lb2bad(const St&s){ // the invalid variant (with +1 for single m-class not at N-2)
  int hx[16];
  for(int x=0;x<N;x++){ int vv[16]; for(int c=0;c<N;c++) vv[c]=-1;
    for(int y=0;y<N;y++) if(y!=x){int c=s.pm[x][y]; vv[c]=max(vv[c],(int)s.cost[x][y]);}
    uint64_t S=0; int k=0,lc=-1,w0=0; for(int c=0;c<N;c++) if(vv[c]>=0){ S+=1ULL<<vv[c]; k++; lc=c; w0=vv[c]; }
    hx[x]=huffSum(S); if(k==1 && lc!=N-2) hx[x]=w0+1; }
  int val[16]; for(int c=0;c<N;c++) val[c]=-1; for(int x=0;x<N;x++){ int c=s.pM[x]; val[c]=max(val[c],hx[x]); }
  uint64_t S=0; for(int c=0;c<N;c++) if(val[c]>=0) S+=1ULL<<val[c]; return huffSum(S);
}
int lb2(const St&s){
  int hx[16];
  for(int x=0;x<N;x++){
    int vv[16]; for(int c=0;c<N;c++) vv[c]=-1;
    for(int y=0;y<N;y++) if(y!=x){int c=s.pm[x][y]; vv[c]=max(vv[c],(int)s.cost[x][y]);}
    uint64_t S=0; for(int c=0;c<N;c++) if(vv[c]>=0) S+=1ULL<<vv[c];
    hx[x]=huffSum(S);  // plain Huffman over m-classes (m-only merges)
  }
  int val[16]; for(int c=0;c<N;c++) val[c]=-1;
  for(int x=0;x<N;x++){ int c=s.pM[x]; val[c]=max(val[c],hx[x]); }
  uint64_t S=0; int cnt=0,lastc=-1,v0=0; for(int c=0;c<N;c++) if(val[c]>=0){ S+=1ULL<<val[c]; cnt++; lastc=c; v0=val[c]; }
  int h=huffSum(S); if(cnt==1 && lastc!=N-1) h=v0+1;
  return h;
}
bool goal(const St&s){
  for(int x=0;x<N;x++){ if(s.pM[x]!=N-1) return false; for(int y=0;y<N;y++) if(y!=x && s.pm[x][y]!=N-2) return false; }
  return true;
}
bool apply(const St&s, int a, int b, St&t){
  t=s; bool moved=false;
  for(int x=0;x<N;x++){
    int Mx=s.pM[x]; bool Mt=(Mx==a||Mx==b);
    for(int y=0;y<N;y++) if(y!=x){
      int my=s.pm[x][y]; bool mt=(my==a||my==b);
      if(Mt||mt){ if(++t.cost[x][y]>L) return false; }
      if(Mt&&mt){ if(my!=a){t.pm[x][y]=a; moved=true;} }
      else if(mt){ if(my!=b){t.pm[x][y]=b; moved=true;} }
    }
    if(Mt && Mx!=b){ t.pM[x]=b; moved=true; }
  }
  return moved;
}

// ---- empirical tests of the brute-force lemmas on real networks ----
mt19937_64 R(12345);
// run a full standard network from the initial state; return per-prefix states
bool runNet(const vector<pair<int,int>>& net, vector<St>& states, int& p2){
  St s; memset(&s,0,sizeof s); for(int x=0;x<N;x++){ s.pM[x]=x; for(int y=0;y<N;y++) s.pm[x][y]=y; }
  states.clear(); states.push_back(s); int saveL=L; L=255;
  for(auto&c:net){ St t; apply(s,c.first,c.second,t); // apply returns false if no move; state still computed? recompute manually
    // manual apply (no pruning)
    t=s; for(int x=0;x<N;x++){ int Mx=s.pM[x]; bool Mt=(Mx==c.first||Mx==c.second); for(int y=0;y<N;y++) if(y!=x){ int my=s.pm[x][y]; bool mt=(my==c.first||my==c.second); if(Mt||mt) t.cost[x][y]++; if(Mt&&mt) t.pm[x][y]=c.first; else if(mt) t.pm[x][y]=c.second; } if(Mt) t.pM[x]=c.second; }
    s=t; states.push_back(s); }
  L=saveL; if(!goal(s)) return false; p2=0; for(int x=0;x<N;x++) for(int y=0;y<N;y++) if(x!=y) p2=max(p2,(int)s.cost[x][y]); return true;
}
// apply general comparator (u,v) with max -> v (v may be < u) to a state, no pruning
St applyGen(const St&s,int u,int v){ St t=s; for(int x=0;x<N;x++){ int Mx=s.pM[x]; bool Mt=(Mx==u||Mx==v); for(int y=0;y<N;y++) if(y!=x){ int my=s.pm[x][y]; bool mt=(my==u||my==v); if(Mt||mt) t.cost[x][y]++; if(Mt&&mt) t.pm[x][y]=u; else if(mt) t.pm[x][y]=v; } if(Mt) t.pM[x]=v; } return t; }
int main(int argc,char**argv){
  N=atoi(argv[1]); int trials=atoi(argv[2]); long long lb2badViol=0, lbViol=0, lb2Viol=0, symFail=0, prefixes=0, nets=0;
  vector<pair<int,int>> pairs; for(int a=0;a<N;a++) for(int b=a+1;b<N;b++) pairs.push_back({a,b});
  string line; vector<vector<pair<int,int>>> pool;
  while(getline(cin,line)){ if(line.empty()) continue; int nn=stoi(line.substr(0,line.find(':'))); if(nn!=N) continue; vector<pair<int,int>> c; size_t p=0; while((p=line.find('(',p))!=string::npos){ int a,b; sscanf(line.c_str()+p,"(%d,%d)",&a,&b); c.push_back({a,b}); p++; } pool.push_back(c); }
  int nrand = argc>3 ? atoi(argv[3]) : 0;
  for(int i=0;i<nrand;i++){ vector<pair<int,int>> c; vector<St> st; int p2;
    while(true){ auto pr=pairs[R()%pairs.size()]; c.push_back(pr); if(runNet(c,st,p2)) break; }
    // greedy minimize (random order) keeping top-2 correctness
    bool ch=true; while(ch){ ch=false; for(int t=0;t<(int)c.size();t++){ int j=R()%c.size(); auto d=c; d.erase(d.begin()+j); if(runNet(d,st,p2)){ c=d; ch=true; } } }
    pool.push_back(c); }
  for(auto& net: pool){ vector<St> st; int p2; if(!runNet(net,st,p2)) continue; nets++;
    for(size_t k=0;k<st.size();k++){ prefixes++; if(lb(st[k])>p2) lbViol++; if(lb2(st[k])>p2) lb2Viol++; if(lb2bad(st[k])>p2) lb2badViol++; }
    // symmetry lemma: random prefix cut k, random sigma (inputs) and pi (channels fixing N-1,N-2); untangle pi(C) from (sigma,pi)S
    for(int tr=0;tr<trials;tr++){ size_t k=R()%st.size(); vector<int> sg(N), pi(N); iota(sg.begin(),sg.end(),0); iota(pi.begin(),pi.end(),0); shuffle(sg.begin(),sg.end(),R); shuffle(pi.begin(),pi.begin()+N-2,R);
      const St& S=st[k]; St T; memset(&T,0,sizeof T);
      for(int x=0;x<N;x++){ T.pM[x]=pi[S.pM[sg[x]]]; for(int y=0;y<N;y++) if(y!=x){ T.pm[x][y]=pi[S.pm[sg[x]][sg[y]]]; T.cost[x][y]=S.cost[sg[x]][sg[y]]; } }
      // untangle pi(C): rho relabeling, initially identity
      vector<int> rho(N); iota(rho.begin(),rho.end(),0); St U=T;
      for(size_t j=k;j<net.size();j++){ int u=pi[net[j].first], v=pi[net[j].second]; // max -> v
        int uu=rho[u], vv=rho[v]; if(uu<vv){ U=applyGen(U,uu,vv); } else { U=applyGen(U,vv,uu); swap(rho[u],rho[v]); } }
      int p2T=0; for(int x=0;x<N;x++) for(int y=0;y<N;y++) if(x!=y) p2T=max(p2T,(int)U.cost[x][y]);
      if(!goal(U) || p2T!=p2) symFail++;
      // also canonHash invariance is not required; but check canon(T) feasibility class consistency is implied
    } }
  printf("lb2badViol=%lld ",lb2badViol); printf("N=%d nets=%lld prefixes=%lld lbViol=%lld lb2Viol=%lld symmetryTrials=%lld symFail=%lld\n",N,nets,prefixes,lbViol,lb2Viol,nets*(long long)trials,symFail);
}

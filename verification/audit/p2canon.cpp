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
struct Node { St s; unsigned touched; vector<pair<int,int>> path; int parent=-1; };
mutex solMu; vector<pair<int,int>> solution;
// children generation identical to p2sym3
template<class F> void children(const St&s, unsigned touched, F f){
  int u0=-1,u1=-1; for(int c=0;c<N;c++) if(!(touched>>c&1)){ if(u0<0) u0=c; else if(u1<0) u1=c; }
  for(int a=0;a<N;a++) for(int b=a+1;b<N;b++){
    bool ta=touched>>a&1, tb=touched>>b&1;
    if(!ta && !tb){ if(!(a==u0 && b==u1)) continue; }
    else if(!ta){ if(a!=u0) continue; }
    else if(!tb){ if(b!=u0) continue; }
    St t; if(!apply(s,a,b,t)) continue;
    if(!f(a,b,t,touched|(1u<<a)|(1u<<b))) return;
  }
}
bool dfs(const St&s, unsigned touched, vector<pair<int,int>>& path){
  tcnt[tid].v++;
  if(found.load(memory_order_relaxed)) return false;
  if(goal(s)){ lock_guard<mutex> lk(solMu); if(!found){ found=true; solution=path; } return true; }
  if(lb(s)>L || lb2(s)>L) return false;
  H128 h=canonHash(s);
  if(memoHas(h)) return false;
  bool res=false;
  children(s,touched,[&](int a,int b,const St&t,unsigned nt){ path.push_back({a,b}); bool r=dfs(t,nt,path); path.pop_back(); if(r){res=true; return false;} return true; });
  if(res) return true;
  if(found.load()) return false;   // aborted: do not record as failed
  memoAdd(h);
  return false;
}
int main(int argc,char**argv){
  N=atoi(argv[1]); L=atoi(argv[2]); int D=atoi(argv[3]); int T=atoi(argv[4]);
  if(getenv("CANON")) CANON=atoi(getenv("CANON")); if(getenv("CROUNDS")) CROUNDS=atoi(getenv("CROUNDS"));
  shards=new Shard[NSH]; double gb = argc>5 ? atof(argv[5]) : 8.0; size_t bucketsPerShard = (size_t)(gb*1e9/16/4/NSH); if(bucketsPerShard<16) bucketsPerShard=16; for(int i=0;i<NSH;i++) shards[i].init(bucketsPerShard);
  fprintf(stderr,"cache: %.1f GB, %zu buckets/shard\n", (double)bucketsPerShard*4*16*NSH/1e9, bucketsPerShard);
  St s0; memset(&s0,0,sizeof s0); for(int x=0;x<N;x++){ s0.pM[x]=x; for(int y=0;y<N;y++) s0.pm[x][y]=y; }
  auto t0=chrono::steady_clock::now();
  // phase 1: frontier at depth D (BFS with dedup by state hash); goal / pruning applied as in dfs
  vector<Node> cur; cur.push_back({s0,0u,{}}); bool done=false;
  for(int d=0; d<D && !done; d++){
    vector<Node> nxt; unordered_set<H128,HH> seen; int canonBFS = getenv("CANONBFS")? atoi(getenv("CANONBFS")) : 1;
    for(auto& nd: cur){
      if(goal(nd.s)){ found=true; solution=nd.path; done=true; break; }
      if(lb(nd.s)>L || lb2(nd.s)>L) continue;
      children(nd.s,nd.touched,[&](int a,int b,const St&t,unsigned nt){ H128 h= canonBFS? canonHash(t) : hashSt(t); if(seen.insert(h).second){ Node m{t,nt,nd.path}; m.path.push_back({a,b}); nxt.push_back(m);} return true; });
    }
    if(!done) cur.swap(nxt);
    fprintf(stderr,"frontier depth %d: %zu nodes\n",d+1,cur.size()); fflush(stderr);
  }
  if(!done){
    size_t F=cur.size();
    vector<char> skip(F,0); if(getenv("SKIPFILE")){ ifstream in(getenv("SKIPFILE")); string w; size_t k; long long ns=0; while(in>>w>>k){ if(w=="DONE" && k<F){ skip[k]=1; ns++; } } fprintf(stderr,"skipping %lld completed items\n",ns); }
    int E = getenv("EXPAND") ? atoi(getenv("EXPAND")) : 2;
    // expand every remaining frontier item E more levels (same pruning), global dedup by state
    vector<Node> sub; for(size_t k=0;k<F;k++) if(!skip[k]){ sub.push_back(cur[k]); sub.back().parent=(int)k; }
    fprintf(stderr,"remaining items: %zu\n",sub.size());
    for(int e=0;e<E && !done;e++){
      vector<Node> nxt; unordered_set<H128,HH> seen;
      for(auto& nd: sub){
        if(goal(nd.s)){ found=true; solution=nd.path; done=true; break; }
        if(lb(nd.s)>L || lb2(nd.s)>L) continue;
        children(nd.s,nd.touched,[&](int a,int b,const St&t,unsigned nt){ H128 h=canonHash(t); if(seen.insert(h).second){ Node m{t,nt,nd.path,nd.parent}; m.path.push_back({a,b}); nxt.push_back(m);} return true; });
      }
      if(!done) sub.swap(nxt);
      fprintf(stderr,"expanded level %d: %zu sub-items\n",e+1,sub.size()); fflush(stderr);
    }
    if(getenv("PRINTPARENTS")){ map<int,int> cnt; for(auto&n:sub) cnt[n.parent]++; for(auto&kv:cnt) printf("parent %d subitems %d\n",kv.first,kv.second); return 0; }
    vector<char> subskip(sub.size(),0); if(getenv("SUBSKIPFILE")){ ifstream in(getenv("SUBSKIPFILE")); string w; size_t k; long long ns=0; while(in>>w>>k){ if(w=="SUBDONE" && k<sub.size()){ subskip[k]=1; ns++; } } fprintf(stderr,"skipping %lld completed sub-items\n",ns); }
    if(!done){
      size_t S=sub.size(); atomic<size_t> idx(0); atomic<size_t> ndone(0); vector<thread> th; mutex logMu;
      for(int i=0;i<T;i++) th.emplace_back([&,i](){ tid=i+1; while(!found){ size_t k=idx++; if(k>=S) break; vector<pair<int,int>> p=sub[k].path; if(subskip[k]){ ndone++; continue; } bool r=dfs(sub[k].s,sub[k].touched,p); if(!r && !found){ ndone++; lock_guard<mutex> lk(logMu); fprintf(stderr,"SUBDONE %zu\n",k);} } });
      thread mon([&](){ while(true){ for(int i=0;i<60;i++){ this_thread::sleep_for(chrono::seconds(1)); if(found || ndone.load()>=S) break; }
          double dt=chrono::duration<double>(chrono::steady_clock::now()-t0).count();
          fprintf(stderr,"[%.0fs] nodes=%lld memo=%lld sub taken %zu done %zu / %zu\n",dt,totalNodes(),totalMemo(),min(idx.load(),S),ndone.load(),S); fflush(stderr);
          if(found || ndone.load()>=S) break; } });
      for(auto&t:th) t.join(); ndone=S; mon.join();
    }
  }
  double dt=chrono::duration<double>(chrono::steady_clock::now()-t0).count();
  printf("N=%d L=%d feasible=%d nodes=%lld memo=%lld time=%.1fs\n",N,L,(int)found.load(),totalNodes(),totalMemo(),dt);
  if(found){ printf("net (%zu):",solution.size()); for(auto&p:solution) printf(" (%d,%d)",p.first,p.second); printf("\n"); }
}

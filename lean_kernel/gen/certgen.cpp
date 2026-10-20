// Certificate generator for P(2,N) > L (untrusted; its output is checked by the Lean kernel).
// usage: certgen N L KEYS_OUT CERTS_OUT        (deterministic; N=13 L=8 gives 99,736 states)
//
// States are the f-states of the clean-room Method A (verify_cleanroom/METHOD.md): e[p][q] = 0 if no
// run has the largest value M on channel p and the second largest m on channel q, else 1 + the
// largest number of comparators met so far by such a run. Breadth-first search from the start state
// over the comparators (lo, hi), lo < hi; a child is dropped if it meets no run ("untouched") or fails
// the Kraft test (potential Phi > 2^L); otherwise it is relabeled into a canonical form (colour
// refinement, bf2's canon) and added if new.
//
// KEYS_OUT: one line per state, in index order (index 0 = start state): the hexadecimal key
//   raw * 2^64 + (raw mod (2^61 - 1)),   raw = sum_{p,q<N} e[p][q] * 16^(N p + q).
// CERTS_OUT: one line per state; for each child that is neither untouched nor Kraft-pruned, an entry
//   ci:sg:tg:j   with ci = 16 lo + hi (decimal), sg = sum_a sigma(a) 16^a and tg = sum_a sigma^-1(a) 16^a
//   (hexadecimal), j = index of the target state (decimal), such that target(p,q) = child(sigma p, sigma q).
#include <bits/stdc++.h>
using namespace std;
typedef unsigned long long u64;
int N, L; long long LIMIT=5040;
struct St { int8_t v[256]; };   // v[p*16+q] = cost or -1
struct Key { u64 w[16]; bool operator==(const Key&o) const { return memcmp(w,o.w,128)==0; } };
struct KH { size_t operator()(const Key&k) const { u64 h=1469598103934665603ULL; for(int i=0;i<16;i++){ h^=k.w[i]; h*=1099511628211ULL; h^=h>>29; } return h; } };

static inline Key encode(const St& s, const int* perm){
  Key k; memset(k.w,0,128);
  for(int p=0;p<N;p++) for(int q=0;q<N;q++) if(p!=q){ int c=s.v[p*16+q]; if(c<0) continue;
    int i=perm[p]*16+perm[q]; k.w[i>>4] |= (u64)((c+1)&15) << (4*(i&15)); }
  return k;
}
static inline bool keyless(const Key&a,const Key&b){ for(int i=15;i>=0;i--) if(a.w[i]!=b.w[i]) return a.w[i]<b.w[i]; return false; }

// returns canonical key and perm (perm[old]=new)
Key canon(const St& s, int* bestperm){
  vector<long long> col(N,0);
  {
    vector<vector<int>> sig(N);
    for(int p=0;p<N;p++){ vector<int> a,b; for(int q=0;q<N;q++) if(q!=p){ if(s.v[p*16+q]>=0) a.push_back(s.v[p*16+q]); if(s.v[q*16+p]>=0) b.push_back(s.v[q*16+p]); }
      sort(a.begin(),a.end()); sort(b.begin(),b.end()); vector<int> g; g.push_back(a.size()); g.insert(g.end(),a.begin(),a.end()); g.push_back(-7); g.push_back(b.size()); g.insert(g.end(),b.begin(),b.end()); sig[p]=g; }
    vector<vector<int>> u=sig; sort(u.begin(),u.end()); u.erase(unique(u.begin(),u.end()),u.end());
    for(int p=0;p<N;p++) col[p]=lower_bound(u.begin(),u.end(),sig[p])-u.begin();
  }
  for(int it=0;it<N;it++){
    vector<vector<long long>> sig(N);
    for(int p=0;p<N;p++){ vector<long long> a,b; for(int q=0;q<N;q++) if(q!=p){ if(s.v[p*16+q]>=0) a.push_back(s.v[p*16+q]*1000+col[q]); if(s.v[q*16+p]>=0) b.push_back(s.v[q*16+p]*1000+col[q]); }
      sort(a.begin(),a.end()); sort(b.begin(),b.end()); vector<long long> g; g.push_back(col[p]); g.push_back(a.size()); g.insert(g.end(),a.begin(),a.end()); g.push_back(-7); g.insert(g.end(),b.begin(),b.end()); sig[p]=g; }
    vector<vector<long long>> u=sig; sort(u.begin(),u.end()); u.erase(unique(u.begin(),u.end()),u.end());
    vector<long long> nc(N); for(int p=0;p<N;p++) nc[p]=lower_bound(u.begin(),u.end(),sig[p])-u.begin();
    int oldk=*max_element(col.begin(),col.end()), newk=*max_element(nc.begin(),nc.end());
    col=nc; if(newk==oldk) break;
  }
  vector<int> order(N); iota(order.begin(),order.end(),0);
  stable_sort(order.begin(),order.end(),[&](int a,int b){return col[a]<col[b];});
  vector<pair<int,int>> groups; for(int i=0;i<N;){int j=i; while(j<N&&col[order[j]]==col[order[i]]) j++; groups.push_back({i,j}); i=j;}
  long long prod=1; for(auto&g:groups){ for(int t=2;t<=g.second-g.first;t++){ prod*=t; if(prod>LIMIT) break;} if(prod>LIMIT) break; }
  int perm[16];
  if(prod>LIMIT){ for(int i=0;i<N;i++) perm[order[i]]=i; memcpy(bestperm,perm,sizeof(perm)); return encode(s,perm); }
  Key best; bool have=false; vector<int> cur=order;
  function<void(int)> rec=[&](int gi){
    if(gi==(int)groups.size()){ for(int i=0;i<N;i++) perm[cur[i]]=i; Key k=encode(s,perm); if(!have||keyless(k,best)){best=k;have=true; memcpy(bestperm,perm,sizeof(perm));} return; }
    int a=groups[gi].first,b=groups[gi].second; sort(cur.begin()+a,cur.begin()+b);
    do{ rec(gi+1);}while(next_permutation(cur.begin()+a,cur.begin()+b));
  };
  rec(0); return best;
}

bool kraft_ok(const St& s){
  u64 lim=1ULL<<L, sum=0;
  for(int p=0;p<N;p++){ u64 sp=0; bool any=false;
    for(int q=0;q<N;q++) if(q!=p && s.v[p*16+q]>=0){ sp+=(1ULL<<s.v[p*16+q]); any=true; }
    if(!any) continue;
    if(sp>lim) return false;
    u64 np=1; while(np<sp) np<<=1;   // next power of two >= sp
    sum+=np; if(sum>lim) return false; }
  return true;
}

// apply comparator (lo,hi): min to lo, max to hi. returns touched.
bool apply(const St& s,int lo,int hi,St& t){
  memset(t.v,-1,256); bool touched=false;
  for(int p=0;p<N;p++) for(int q=0;q<N;q++){ if(p==q) continue; int c=s.v[p*16+q]; if(c<0) continue;
    int pM=p,pm=q; bool iM=(pM==lo||pM==hi), im=(pm==lo||pm==hi);
    if(iM||im){ touched=true; c++; if(iM&&im){pM=hi;pm=lo;} else if(iM) pM=hi; else pm=hi; }
    int8_t &d=t.v[pM*16+pm]; if(c>d) d=(int8_t)c; }
  return touched;
}

// salted key as hex: raw nibbles then 16 hex digits of salt
string saltedkey(const St& s){
  int M=N*N; vector<int> nib(M,0);
  for(int p=0;p<N;p++) for(int q=0;q<N;q++){ int c=s.v[p*16+q]; nib[N*p+q]= (c<0)?0:(c+1); }
  // raw mod P, P = 2^61-1, Horner from most significant nibble
  const unsigned __int128 P=(((unsigned __int128)1)<<61)-1; unsigned __int128 r=0;
  for(int i=M-1;i>=0;i--){ r=(r*16+nib[i])%P; }
  string out; int top=M-1; while(top>0 && nib[top]==0) top--;
  static const char* H="0123456789abcdef";
  for(int i=top;i>=0;i--) out.push_back(H[nib[i]]);
  char buf[32]; snprintf(buf,sizeof buf,"%016llx",(unsigned long long)r); out+=buf;
  return out;
}
St relabel(const St& s, const int* perm){ St t; memset(t.v,-1,256);
  for(int p=0;p<N;p++) for(int q=0;q<N;q++) if(s.v[p*16+q]>=0) t.v[perm[p]*16+perm[q]]=s.v[p*16+q];
  return t; }

int main(int argc,char**argv){
  N=atoi(argv[1]); L=atoi(argv[2]);
  for(int i=3;i<argc;i++){ if(!strcmp(argv[i],"-lim")) LIMIT=atoll(argv[++i]); }
  St s0; memset(s0.v,-1,256); for(int p=0;p<N;p++) for(int q=0;q<N;q++) if(p!=q) s0.v[p*16+q]=0;
  if(!kraft_ok(s0)){ printf("ROOT_PRUNED\n"); return 0; }
  int perm[16]; Key k0=canon(s0,perm); St c0=relabel(s0,perm);
  unordered_map<Key,int,KH> idx; vector<St> states; idx[k0]=0; states.push_back(c0);
  vector<pair<int,int>> cmps; for(int lo=0;lo<N;lo++) for(int hi=lo+1;hi<N;hi++) cmps.push_back({lo,hi});
  long long nU=0,nK=0,nC=0;
  vector<vector<string>> certs;
  for(size_t si=0; si<states.size(); si++){
    St s=states[si];
    int cnt=0; for(int p=0;p<N;p++) for(int q=0;q<N;q++) if(s.v[p*16+q]>=0) cnt++;
    if(cnt<=1){ printf("FEASIBLE at state %zu\n",si); return 1; }
    for(size_t ci=0; ci<cmps.size(); ci++){
      St t; bool touched=apply(s,cmps[ci].first,cmps[ci].second,t);
      if(!touched){ nU++; continue; }
      if(!kraft_ok(t)){ nK++; continue; }
      Key k=canon(t,perm);
      auto it=idx.find(k); size_t tj;
      if(it==idx.end()){ tj=states.size(); idx[k]=tj; states.push_back(relabel(t,perm)); } else tj=it->second;
      nC++;
      // pull permutation sigma = perm^{-1}: target(p,q) = t(sigma p, sigma q)
      int inv[16]; for(int a=0;a<N;a++) inv[perm[a]]=a;
      u64 sg=0, tg=0; for(int a=0;a<N;a++){ sg |= (u64)inv[a] << (4*a); tg |= (u64)perm[a] << (4*a); }
      int cid = 16*cmps[ci].first + cmps[ci].second;
      char buf[128]; snprintf(buf,sizeof buf,"%d:%llx:%llx:%zu",cid,(unsigned long long)sg,(unsigned long long)tg,tj);
      if(certs.size()<=si) certs.resize(si+1);
      certs[si].push_back(buf);
    }
  }
  // keys file
  { FILE* f=fopen(argv[3],"w"); for(size_t i=0;i<states.size();i++) fprintf(f,"%s\n", saltedkey(states[i]).c_str()); fclose(f); }
  // cert file: one line per state
  { FILE* f=fopen(argv[4],"w"); certs.resize(states.size());
    for(size_t i=0;i<states.size();i++){ for(size_t k=0;k<certs[i].size();k++) fprintf(f,"%s%s", k?" ":"", certs[i][k].c_str()); fprintf(f,"\n"); } fclose(f); }
  fprintf(stderr,"N=%d L=%d states=%zu untouched=%lld kraft=%lld iso=%lld\n",N,L,states.size(),nU,nK,nC);
  return 0;
}

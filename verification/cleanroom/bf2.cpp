// Brute force for P(2,N), N <= 16 (same state model as bf.cpp).
// State after a prefix: f(p,q) = max |W| so far over runs with M on channel
// p and m on channel q (absent = -1).  Runs evolve independently, so the
// future depends only on f.  Dedup key = f relabeled by a channel ordering
// obtained from colour refinement (+ exhaustive tie enumeration when small,
// else index tie-break).  Equal keys => isomorphic states, so dedup is sound
// even when it is not perfectly canonical.
// Pruning: (P0) cost <= L; (P1) frozen entry; (P2, -k) Kraft bound.
// Usage: bf2 N L [-k] [-all] [-lim X]
#include <bits/stdc++.h>
using namespace std;
typedef unsigned long long u64;
int N, L; bool KR=false, ALLOR=false; long long LIMIT=5040; unsigned SEED=0; std::mt19937 RNG;
struct St { int8_t v[256]; };
struct Key { u64 w[16]; bool operator==(const Key&o) const { return memcmp(w,o.w,128)==0; } };
struct KH { size_t operator()(const Key&k) const { u64 h=1469598103934665603ULL; for(int i=0;i<16;i++){ h^=k.w[i]; h*=1099511628211ULL; h^=h>>29; } return h; } };

static inline Key encode(const St& s, const int* perm){
  Key k; memset(k.w,0,128);
  for(int p=0;p<N;p++) for(int q=0;q<N;q++) if(p!=q){ int c=s.v[p*16+q]; if(c<0) continue;
    int i=perm[p]*16+perm[q]; k.w[i>>4] |= (u64)((c+1)&15) << (4*(i&15)); }
  return k;
}
static inline bool keyless(const Key&a,const Key&b){ for(int i=15;i>=0;i--) if(a.w[i]!=b.w[i]) return a.w[i]<b.w[i]; return false; }

Key canon(const St& s){
  // colour refinement
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
  if(prod>LIMIT){ for(int i=0;i<N;i++) perm[order[i]]=i; return encode(s,perm); }
  Key best; bool have=false; vector<int> cur=order;
  function<void(int)> rec=[&](int gi){
    if(gi==(int)groups.size()){ for(int i=0;i<N;i++) perm[cur[i]]=i; Key k=encode(s,perm); if(!have||keyless(k,best)){best=k;have=true;} return; }
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
    int A=0; while((sp<<(A+1))<=lim) A++;
    sum+=(1ULL<<(L-A)); if(sum>lim) return false; }
  return true;
}

unordered_set<Key,KH> seen; vector<pair<int,int>> path, witness; long long nodes=0; bool found=false;

bool apply(const St& s,int lo,int hi,St& t){
  memset(t.v,-1,256); bool touched=false;
  for(int p=0;p<N;p++) for(int q=0;q<N;q++){ if(p==q) continue; int c=s.v[p*16+q]; if(c<0) continue;
    int pM=p,pm=q; bool iM=(pM==lo||pM==hi), im=(pm==lo||pm==hi);
    if(iM||im){ touched=true; c++; if(c>L) return false; if(iM&&im){pM=hi;pm=lo;} else if(iM) pM=hi; else pm=hi; }
    int8_t &d=t.v[pM*16+pm]; if(c>d) d=(int8_t)c; }
  if(!touched) return false;
  int frozen=0,cnt=0; for(int p=0;p<N;p++) for(int q=0;q<N;q++){ int c=t.v[p*16+q]; if(c>=0){cnt++; if(c==L) frozen++;} }
  if(frozen>=2) return false;
  if(frozen==1 && cnt>1) return false;
  if(KR && !kraft_ok(t)) return false;
  return true;
}

void dfs(const St& s){
  if(found) return; nodes++;
  if((nodes&((1<<20)-1))==0){ fprintf(stderr,"nodes=%lld seen=%zu depth=%zu\n",nodes,seen.size(),path.size()); }
  int cnt=0; for(int p=0;p<N;p++) for(int q=0;q<N;q++) if(s.v[p*16+q]>=0) cnt++;
  if(cnt==1){ found=true; witness=path; return; }
  vector<pair<int,int>> mv;
  for(int lo=0;lo<N;lo++) for(int hi=0;hi<N;hi++){ if(lo==hi) continue; if(!ALLOR && lo>hi) continue; mv.push_back({lo,hi}); }
  if(SEED) shuffle(mv.begin(),mv.end(),RNG);
  for(auto& m: mv){ int lo=m.first, hi=m.second;
    St t; if(!apply(s,lo,hi,t)) continue; Key k=canon(t); if(!seen.insert(k).second) continue;
    path.push_back({lo,hi}); dfs(t); path.pop_back(); if(found) return; }
}

int main(int argc,char**argv){
  N=atoi(argv[1]); L=atoi(argv[2]);
  for(int i=3;i<argc;i++){ if(!strcmp(argv[i],"-k")) KR=true; else if(!strcmp(argv[i],"-all")) ALLOR=true; else if(!strcmp(argv[i],"-lim")) LIMIT=atoll(argv[++i]); else if(!strcmp(argv[i],"-seed")){ SEED=atoi(argv[++i]); RNG.seed(SEED);} }
  if(N>16||L>14){ fprintf(stderr,"bounds\n"); return 1; }
  St s; memset(s.v,-1,256); for(int p=0;p<N;p++) for(int q=0;q<N;q++) if(p!=q) s.v[p*16+q]=0;
  auto t0=chrono::steady_clock::now();
  bool rootok = !KR || kraft_ok(s);
  if(rootok){ seen.insert(canon(s)); dfs(s); }
  double el=chrono::duration<double>(chrono::steady_clock::now()-t0).count();
  printf("N=%d L=%d kraft=%d allor=%d lim=%lld : %s  states=%zu nodes=%lld time=%.2fs\n",N,L,(int)KR,(int)ALLOR,LIMIT,found?"FEASIBLE":"INFEASIBLE",seen.size(),nodes,el);
  if(found){ printf("witness:"); for(auto&c:witness) printf(" %d,%d",c.first,c.second); printf("\n"); }
}

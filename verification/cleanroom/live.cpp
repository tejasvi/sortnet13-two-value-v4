// Exhaustive soundness test of the pruning rules used in bf2.
// Explores the FULL state graph with only (P0) cost <= L (no P1, no Kraft),
// computes which states are "live" (can reach a goal state), and checks that
// every live state passes the Kraft test and is not killed by the frozen rule
// (P1).  A live state failing either test would mean the prune is unsound.
// Usage: live N L
#include <bits/stdc++.h>
using namespace std;
typedef unsigned long long u64;
int N, L; long long LIMIT=5040;
struct St { int8_t v[256]; };
struct Key { u64 w[16]; bool operator==(const Key&o) const { return memcmp(w,o.w,128)==0; } };
struct KH { size_t operator()(const Key&k) const { u64 h=1469598103934665603ULL; for(int i=0;i<16;i++){ h^=k.w[i]; h*=1099511628211ULL; h^=h>>29; } return h; } };
static inline Key encode(const St& s, const int* perm){ Key k; memset(k.w,0,128);
  for(int p=0;p<N;p++) for(int q=0;q<N;q++) if(p!=q){ int c=s.v[p*16+q]; if(c<0) continue; int i=perm[p]*16+perm[q]; k.w[i>>4] |= (u64)((c+1)&15) << (4*(i&15)); }
  return k; }
static inline bool keyless(const Key&a,const Key&b){ for(int i=15;i>=0;i--) if(a.w[i]!=b.w[i]) return a.w[i]<b.w[i]; return false; }
St decode(const Key&k){ St s; memset(s.v,-1,256); for(int i=0;i<256;i++){ int x=(k.w[i>>4]>>(4*(i&15)))&15; if(x) s.v[i]=x-1; } return s; }
Key canon(const St& s){
  vector<long long> col(N,0);
  for(int it=0;it<=N;it++){
    vector<vector<long long>> sig(N);
    for(int p=0;p<N;p++){ vector<long long> a,b; for(int q=0;q<N;q++) if(q!=p){ if(s.v[p*16+q]>=0) a.push_back(s.v[p*16+q]*1000+col[q]); if(s.v[q*16+p]>=0) b.push_back(s.v[q*16+p]*1000+col[q]); }
      sort(a.begin(),a.end()); sort(b.begin(),b.end()); vector<long long> g; g.push_back(col[p]); g.push_back(a.size()); g.insert(g.end(),a.begin(),a.end()); g.push_back(-7); g.insert(g.end(),b.begin(),b.end()); sig[p]=g; }
    vector<vector<long long>> u=sig; sort(u.begin(),u.end()); u.erase(unique(u.begin(),u.end()),u.end());
    vector<long long> nc(N); for(int p=0;p<N;p++) nc[p]=lower_bound(u.begin(),u.end(),sig[p])-u.begin();
    bool same = (*max_element(nc.begin(),nc.end()) == *max_element(col.begin(),col.end())) && it>0;
    col=nc; if(same) break; }
  vector<int> order(N); iota(order.begin(),order.end(),0);
  stable_sort(order.begin(),order.end(),[&](int a,int b){return col[a]<col[b];});
  vector<pair<int,int>> groups; for(int i=0;i<N;){int j=i; while(j<N&&col[order[j]]==col[order[i]]) j++; groups.push_back({i,j}); i=j;}
  long long prod=1; for(auto&g:groups){ for(int t=2;t<=g.second-g.first;t++){ prod*=t; if(prod>LIMIT) break;} if(prod>LIMIT) break; }
  int perm[16];
  if(prod>LIMIT){ for(int i=0;i<N;i++) perm[order[i]]=i; return encode(s,perm); }
  Key best; bool have=false; vector<int> cur=order;
  function<void(int)> rec=[&](int gi){ if(gi==(int)groups.size()){ for(int i=0;i<N;i++) perm[cur[i]]=i; Key k=encode(s,perm); if(!have||keyless(k,best)){best=k;have=true;} return; }
    int a=groups[gi].first,b=groups[gi].second; sort(cur.begin()+a,cur.begin()+b); do{ rec(gi+1);}while(next_permutation(cur.begin()+a,cur.begin()+b)); };
  rec(0); return best; }
bool kraft_ok(const St& s){ u64 lim=1ULL<<L, sum=0;
  for(int p=0;p<N;p++){ u64 sp=0; bool any=false; for(int q=0;q<N;q++) if(q!=p && s.v[p*16+q]>=0){ sp+=(1ULL<<s.v[p*16+q]); any=true; }
    if(!any) continue; if(sp>lim) return false; int A=0; while((sp<<(A+1))<=lim) A++; sum+=(1ULL<<(L-A)); if(sum>lim) return false; }
  return true; }
bool frozen_ok(const St& t){ int frozen=0,cnt=0; for(int i=0;i<256;i++){ int c=t.v[i]; if(c>=0){cnt++; if(c==L) frozen++;} } if(frozen>=2) return false; if(frozen==1&&cnt>1) return false; return true; }
bool apply(const St& s,int lo,int hi,St& t){ memset(t.v,-1,256); bool touched=false;
  for(int p=0;p<N;p++) for(int q=0;q<N;q++){ if(p==q) continue; int c=s.v[p*16+q]; if(c<0) continue; int pM=p,pm=q; bool iM=(pM==lo||pM==hi), im=(pm==lo||pm==hi);
    if(iM||im){ touched=true; c++; if(c>L) return false; if(iM&&im){pM=hi;pm=lo;} else if(iM) pM=hi; else pm=hi; }
    int8_t &d=t.v[pM*16+pm]; if(c>d) d=(int8_t)c; }
  return touched; }
int main(int argc,char**argv){ N=atoi(argv[1]); L=atoi(argv[2]);
  unordered_map<Key,int,KH> id; vector<Key> keys; vector<vector<int>> succ;
  St s; memset(s.v,-1,256); for(int p=0;p<N;p++) for(int q=0;q<N;q++) if(p!=q) s.v[p*16+q]=0;
  Key k0=canon(s); id[k0]=0; keys.push_back(k0); succ.push_back({});
  for(size_t i=0;i<keys.size();i++){ St a=decode(keys[i]);
    for(int lo=0;lo<N;lo++) for(int hi=lo+1;hi<N;hi++){ St b; if(!apply(a,lo,hi,b)) continue; Key kb=canon(b);
      auto it=id.find(kb); int j; if(it==id.end()){ j=keys.size(); id[kb]=j; keys.push_back(kb); succ.push_back({}); } else j=it->second;
      succ[i].push_back(j); } }
  size_t S=keys.size(); vector<vector<int>> pred(S); vector<char> live(S,0); deque<int> dq;
  for(size_t i=0;i<S;i++){ for(int j:succ[i]) pred[j].push_back(i); St a=decode(keys[i]); int cnt=0; for(int t=0;t<256;t++) if(a.v[t]>=0) cnt++; if(cnt==1){ live[i]=1; dq.push_back(i);} }
  while(!dq.empty()){ int j=dq.front(); dq.pop_front(); for(int i:pred[j]) if(!live[i]){ live[i]=1; dq.push_back(i);} }
  long long nl=0, kfail=0, ffail=0, kcut=0, fcut=0;
  for(size_t i=0;i<S;i++){ St a=decode(keys[i]); bool k=kraft_ok(a), f=frozen_ok(a);
    if(live[i]){ nl++; if(!k) kfail++; if(!f) ffail++; } else { if(!k) kcut++; if(!f) fcut++; } }
  printf("N=%d L=%d states=%zu live=%lld | live failing Kraft=%lld, live failing P1=%lld | dead states cut by Kraft=%lld, by P1=%lld | root live=%d\n",
    N,L,S,nl,kfail,ffail,kcut,fcut,(int)live[0]);
}

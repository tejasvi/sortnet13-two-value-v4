// Brute force for P(2,N): exhaustive search over comparator networks,
// independent of the tree model.  State after a prefix of comparators:
//   f(p,q) = max |W| so far over runs whose M is on channel p and m on q
//   (absent if no run is there).  Runs evolve independently, so f
//   determines the future.  States are canonicalized under channel
//   permutations.  Goal: a single entry (all runs at (oM,om)), cost <= L.
// Pruning (both proved in METHOD.md):
//   (P0) cost <= L;
//   (P1) entries with cost L are frozen: at most one; comparators that touch
//        its channels are forbidden;  [only consequence of P0]
//   (P2) optional Kraft bound (flag -k).
// Usage: bf N L [-k] [-all]   (-all: also try both orientations)
#include <bits/stdc++.h>
using namespace std;
typedef unsigned long long u64;
int N, L;
bool KR = false, ALLOR = false;
struct St { int8_t v[64]; };
struct Key { u64 w[4]; bool operator==(const Key&o) const { return memcmp(w,o.w,32)==0; } };
struct KH { size_t operator()(const Key&k) const { u64 h=k.w[0]*0x9E3779B97F4A7C15ULL; h^=k.w[1]+0x632BE59BD9B4E019ULL+(h<<6)+(h>>2); h^=k.w[2]*0xBF58476D1CE4E5B9ULL+(h<<6)+(h>>2); h^=k.w[3]*0x94D049BB133111EBULL+(h<<6)+(h>>2); return h; } };

Key encode(const St& s, const int* perm) { // perm[old]=new
  int8_t t[64]; memset(t, -1, 64);
  for (int p=0;p<N;p++) for (int q=0;q<N;q++) if (p!=q && s.v[p*8+q]>=0) t[perm[p]*8+perm[q]] = s.v[p*8+q];
  Key k; memset(k.w,0,32);
  for (int i=0;i<64;i++){ u64 x = (u64)(t[i]+1)&15; k.w[i/16] |= x << (4*(i%16)); }
  return k;
}
bool keyless(const Key&a,const Key&b){ for(int i=3;i>=0;i--) if(a.w[i]!=b.w[i]) return a.w[i]<b.w[i]; return false; }

Key canon(const St& s) {
  // channel signature: sorted costs as M-position, sorted costs as m-position
  vector<pair<vector<int>,int>> sig(N);
  for (int p=0;p<N;p++){
    vector<int> a,b;
    for (int q=0;q<N;q++) if(q!=p){ if(s.v[p*8+q]>=0) a.push_back(s.v[p*8+q]); if(s.v[q*8+p]>=0) b.push_back(s.v[q*8+p]); }
    sort(a.begin(),a.end()); sort(b.begin(),b.end());
    vector<int> g; g.push_back(a.size()); for(int x:a) g.push_back(x); g.push_back(100); g.push_back(b.size()); for(int x:b) g.push_back(x);
    sig[p] = {g,p};
  }
  sort(sig.begin(), sig.end());
  // groups of equal signatures
  vector<int> order(N); for(int i=0;i<N;i++) order[i]=sig[i].second;
  vector<pair<int,int>> groups; // [start,end)
  for (int i=0;i<N;){ int j=i; while(j<N && sig[j].first==sig[i].first) j++; groups.push_back({i,j}); i=j; }
  // enumerate permutations within groups
  Key best; bool have=false;
  vector<int> cur = order;
  function<void(int)> rec = [&](int gi){
    if (gi==(int)groups.size()){
      int perm[8]; for(int i=0;i<N;i++) perm[cur[i]] = i;
      Key k = encode(s, perm);
      if(!have || keyless(k,best)){ best=k; have=true; }
      return;
    }
    int a=groups[gi].first, b=groups[gi].second;
    sort(cur.begin()+a, cur.begin()+b);
    do { rec(gi+1); } while (next_permutation(cur.begin()+a, cur.begin()+b));
  };
  rec(0);
  return best;
}

bool kraft_ok(const St& s){
  // for each M-position p: S_p * 2^L = sum_q 2^{c(p,q)} ; A_p = max a: 2^a*S_p <= 1
  // need sum_p 2^{-A_p} <= 1   (scaled by 2^{L})
  long double tot = 0; // use exact integers instead
  u64 sum = 0; // sum_p 2^{L - A_p}, need <= 2^L
  for (int p=0;p<N;p++){
    u64 sp = 0; bool any=false;
    for (int q=0;q<N;q++) if(q!=p && s.v[p*8+q]>=0){ sp += (1ULL<<s.v[p*8+q]); any=true; }
    if(!any) continue;
    if (sp > (1ULL<<L)) return false;
    int A=0; while ((sp<<(A+1)) <= (1ULL<<L)) A++;
    if (A > L) A = L;
    sum += (1ULL<<(L-A));
    if (sum > (1ULL<<L)) return false;
  }
  (void)tot;
  return true;
}

unordered_set<Key,KH> seen;
vector<pair<int,int>> path, witness;
long long nodes=0;
bool found=false;

bool apply(const St& s, int lo, int hi, St& t){
  memset(t.v,-1,64);
  bool touched=false;
  for (int p=0;p<N;p++) for(int q=0;q<N;q++){ if(p==q) continue; int c=s.v[p*8+q]; if(c<0) continue;
    int pM=p, pm=q; bool iM=(pM==lo||pM==hi), im=(pm==lo||pm==hi);
    if (iM||im){ touched=true; c++; if(c>L) return false; if(iM&&im){pM=hi;pm=lo;} else if(iM) pM=hi; else pm=hi; }
    int8_t &d = t.v[pM*8+pm]; if (c>d) d=(int8_t)c; }
  if(!touched) return false;
  // P1: frozen entries
  int frozen=0; for(int i=0;i<64;i++) if(t.v[i]==L) frozen++;
  int cnt=0; for(int i=0;i<64;i++) if(t.v[i]>=0) cnt++;
  if (frozen>=2) return false;
  if (frozen==1 && cnt>1){
    // channels of the frozen entry can never be touched again; other entries
    // must still reach (p,q) which requires touching p or q -> impossible
    return false;
  }
  if (KR && !kraft_ok(t)) return false;
  return true;
}

void dfs(const St& s){
  if (found) return;
  nodes++;
  int cnt=0; for(int i=0;i<64;i++) if(s.v[i]>=0) cnt++;
  if (cnt==1){ found=true; witness=path; return; }
  for (int lo=0;lo<N;lo++) for (int hi=0;hi<N;hi++){
    if (lo==hi) continue;
    if (!ALLOR && lo>hi) continue;
    St t; if(!apply(s,lo,hi,t)) continue;
    Key k = canon(t);
    if (!seen.insert(k).second) continue;
    path.push_back({lo,hi}); dfs(t); path.pop_back();
    if (found) return;
  }
}

int main(int argc,char**argv){
  N=atoi(argv[1]); L=atoi(argv[2]);
  for(int i=3;i<argc;i++){ if(!strcmp(argv[i],"-k")) KR=true; if(!strcmp(argv[i],"-all")) ALLOR=true; }
  St s; memset(s.v,-1,64);
  for(int p=0;p<N;p++) for(int q=0;q<N;q++) if(p!=q) s.v[p*8+q]=0;
  seen.insert(canon(s));
  dfs(s);
  printf("N=%d L=%d kraft=%d allor=%d : %s  states=%zu nodes=%lld\n",N,L,(int)KR,(int)ALLOR,found?"FEASIBLE":"INFEASIBLE",seen.size(),nodes);
  if(found){ printf("witness:"); for(auto&c:witness) printf(" %d,%d",c.first,c.second); printf("\n"); }
}

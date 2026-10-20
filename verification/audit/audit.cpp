// Adversarial audit harness for abs5.
// Generates top-2-correct networks, reduces them (R5), extracts the abstract structure
// (branch tree, pass-throughs, blue forest roots/depths), maps it to abs5's numbering and
// checks it against abs5's own code (abs5_core.h = abs5.cpp minus main, plus forced-path filters).
#include "abs5_core.h"

namespace aud {
using namespace std;
mt19937_64 rng(1);
int rnd(int n){ return (int)(rng()%n); }

struct C { int a,b,hi,lo; };
struct DNet { int n=0; int nl=0; vector<int> in; vector<C> cs; int oM=-1, om=-1; };

DNet fromStd(int n, const vector<pair<int,int>>& cmp){
  DNet d; d.n=n; d.nl=n; d.in.resize(n); vector<int> cur(n);
  for(int x=0;x<n;x++){ d.in[x]=x; cur[x]=x; }
  for(auto&p:cmp){ int a=p.first,b=p.second; C c; c.a=cur[a]; c.b=cur[b]; c.hi=d.nl++; c.lo=d.nl++; cur[b]=c.hi; cur[a]=c.lo; d.cs.push_back(c); }
  d.oM=cur[n-1]; d.om=cur[n-2];
  return d;
}
// simulate run (x,y); returns cost; sets okM/okm
int simRun(const DNet& d, int x, int y, vector<int>& val, bool& ok){
  val.assign(d.nl,0); val[d.in[x]]=2; val[d.in[y]]=1; int cost=0;
  for(auto&c:d.cs){ int u=val[c.a], v=val[c.b]; if(u||v) cost++; val[c.hi]=max(u,v); val[c.lo]=min(u,v); }
  ok = (val[d.oM]==2 && val[d.om]==1);
  return cost;
}
// full evaluation: top2 correct? p2, per-pair costs, red/rel leads
struct Eval { bool top2=true; int p2=0; vector<vector<int>> cost; vector<char> red, rel; };
Eval evalNet(const DNet& d){
  Eval e; int n=d.n; e.cost.assign(n,vector<int>(n,0)); e.red.assign(d.nl,0); e.rel.assign(d.nl,0); vector<int> val;
  for(int x=0;x<n;x++) for(int y=0;y<n;y++) if(x!=y){ bool ok; int c=simRun(d,x,y,val,ok); if(!ok) e.top2=false; e.cost[x][y]=c; e.p2=max(e.p2,c);
      for(int l=0;l<d.nl;l++){ if(val[l]==2) e.red[l]=1; else if(val[l]==1) e.rel[l]=1; } }
  return e;
}
// standard-network top2 check (fast): channels
bool top2Std(int n, const vector<pair<int,int>>& cmp, int* p2out=nullptr){
  int p2=0;
  for(int x=0;x<n;x++) for(int y=0;y<n;y++) if(x!=y){ int pM=x,pm=y,cost=0;
      for(auto&p:cmp){ int a=p.first,b=p.second; bool tM=(pM==a||pM==b), tm=(pm==a||pm==b); if(tM||tm) cost++;
        if(tM&&tm){ pM=b; pm=a; } else if(tM){ pM=b; } else if(tm){ pm=b; } }
      if(pM!=n-1||pm!=n-2) return false; p2=max(p2,cost); }
  if(p2out) *p2out=p2; return true;
}
int p2Std(int n, const vector<pair<int,int>>& cmp, int& viol){
  int p2=0; viol=0;
  for(int x=0;x<n;x++) for(int y=0;y<n;y++) if(x!=y){ int pM=x,pm=y,cost=0;
      for(auto&p:cmp){ int a=p.first,b=p.second; bool tM=(pM==a||pM==b), tm=(pm==a||pm==b); if(tM||tm) cost++;
        if(tM&&tm){ pM=b; pm=a; } else if(tM){ pM=b; } else if(tm){ pm=b; } }
      if(pM!=n-1||pm!=n-2) viol++; p2=max(p2,cost); }
  return p2;
}
// R5 reduction: remove one removable comparator; returns false if none
bool reduceOnce(DNet& d){
  Eval e=evalNet(d);
  for(size_t k=0;k<d.cs.size();k++){ C c=d.cs[k]; int ra=e.red[c.a], rb=e.red[c.b]; int keepHi=-1, keepLo=-1;
    if(ra+rb==1){ int blue= ra? c.b : c.a; int redl= ra? c.a : c.b; if(!e.rel[blue]){ keepHi=redl; keepLo=blue; } }
    else if(ra+rb==0){ if(!e.rel[c.a]){ keepHi=c.b; keepLo=c.a; } else if(!e.rel[c.b]){ keepHi=c.a; keepLo=c.b; } }
    if(keepHi>=0){
      for(size_t j=k+1;j<d.cs.size();j++){ C& q=d.cs[j];
        if(q.a==c.hi) q.a=keepHi; else if(q.a==c.lo) q.a=keepLo;
        if(q.b==c.hi) q.b=keepHi; else if(q.b==c.lo) q.b=keepLo; }
      if(d.oM==c.hi) d.oM=keepHi; else if(d.oM==c.lo) d.oM=keepLo;
      if(d.om==c.hi) d.om=keepHi; else if(d.om==c.lo) d.om=keepLo;
      d.cs.erase(d.cs.begin()+k); return true; }
  }
  return false;
}
// ---------- structure extraction ----------
struct Feat { int nPt=0, nPtRoot=0, nPtLeaf=0, nDead=0, nPtSrcLive=0, nBlue=0, nPortDepth0=0, maxDepth=0, nEscape=0, nViaOnPath=0, multiPort=0, ptsSameSeg=0, climbMulti=0; };
struct Extract {
  bool ok=false; string err;
  string shape; vector<int> kseg; vector<int> tRoot, tDep; vector<int> leafMap; // channel -> abs5 leaf id
  Feat f;
};
string canonStr(int v, const vector<int>& ch1, const vector<int>& ch2, vector<string>& memo){
  if(!memo[v].empty()) return memo[v];
  if(ch1[v]<0) return memo[v]="L";
  string s=canonStr(ch1[v],ch1,ch2,memo), t=canonStr(ch2[v],ch1,ch2,memo);
  return memo[v]= s<t ? "("+s+t+")" : "("+t+s+")";
}
Extract extract(const DNet& d){
  Extract X; int n=d.n; Eval e=evalNet(d);
  if(!e.top2){ X.err="not top2"; return X; }
  int nc=d.cs.size(); vector<int> cons(d.nl,-1); for(int k=0;k<nc;k++){ cons[d.cs[k].a]=k; cons[d.cs[k].b]=k; }
  vector<int> type(nc); for(int k=0;k<nc;k++) type[k]=e.red[d.cs[k].a]+e.red[d.cs[k].b];
  // B nodes: 0..n-1 leaves (channels), n.. branch comps
  vector<int> branchIdx(nc,-1); int nb=0; for(int k=0;k<nc;k++) if(type[k]==2) branchIdx[k]=n+(nb++);
  if(nb!=n-1){ X.err="branch count "+to_string(nb); return X; }
  int tot=2*n-1; vector<int> topLead(tot), par(tot,-2); vector<vector<int>> seg(tot); vector<int> nodeComp(tot,-1);
  for(int x=0;x<n;x++) topLead[x]=d.in[x];
  for(int k=0;k<nc;k++) if(type[k]==2){ topLead[branchIdx[k]]=d.cs[k].hi; nodeComp[branchIdx[k]]=k; }
  vector<int> ptNode(nc,-1), ptIdx(nc,-1);
  int rootNode=-1;
  for(int v=0;v<tot;v++){ int l=topLead[v];
    while(true){ int j=cons[l]; if(j<0){ if(l!=d.oM){ X.err="red lead ends at non-oM output"; return X; } par[v]=-1; if(rootNode>=0){X.err="two roots";return X;} rootNode=v; break; }
      if(type[j]==1){ const C&c=d.cs[j]; int redIn = e.red[c.a]? c.a : c.b; if(redIn!=l){ X.err="red lead into blue input?"; return X; } ptNode[j]=v; ptIdx[j]=seg[v].size(); seg[v].push_back(j); l=c.hi; continue; }
      if(type[j]==2){ par[v]=branchIdx[j]; break; }
      X.err="red lead into blue comparator"; return X; } }
  vector<int> ch1(tot,-1), ch2(tot,-1);
  for(int v=0;v<tot;v++) if(par[v]>=0){ int p=par[v]; if(ch1[p]<0) ch1[p]=v; else if(ch2[p]<0) ch2[p]=v; else { X.err="3 children"; return X; } }
  for(int v=n;v<tot;v++) if(ch1[v]<0||ch2[v]<0){ X.err="branch with <2 children"; return X; }
  // relevant structure checks
  for(int k=0;k<nc;k++){ const C&c=d.cs[k];
    if(type[k]==0){ if(!e.rel[c.a]||!e.rel[c.b]){ X.err="blue comp with irrelevant input (not reduced)"; return X; } if(e.rel[c.lo]){ X.err="blue lo relevant?!"; return X; } }
    if(type[k]==1){ int blue = e.red[c.a]? c.b : c.a; if(!e.rel[blue]){ X.err="pt with irrelevant port (not reduced)"; return X; } }
    if(type[k]>=1 && e.red[c.lo]){ X.err="lo red?!"; return X; } }
  // canonical numbering
  vector<string> memo(tot); string shape=canonStr(rootNode,ch1,ch2,memo);
  vector<int> aid(tot,-1); int leafCnt=0,intCnt=n;
  function<void(int)> vis=[&](int v){ if(ch1[v]<0){ aid[v]=leafCnt++; return; } int a=ch1[v], b=ch2[v]; if(memo[b]<memo[a]) swap(a,b); vis(a); vis(b); aid[v]=intCnt++; };
  vis(rootNode);
  X.shape=shape; X.kseg.assign(tot,0); X.leafMap.assign(n,-1);
  for(int x=0;x<n;x++) X.leafMap[x]=aid[x];
  vector<int> inv(tot); for(int v=0;v<tot;v++) inv[aid[v]]=v;
  for(int v=0;v<tot;v++) X.kseg[aid[v]]=seg[v].size();
  // pts numbering in abs5 order
  vector<int> ptP(nc,-1); int np=0; for(int av=0;av<tot;av++){ int v=inv[av]; for(int j: seg[v]) ptP[j]=np++; }
  int NBl=n-1, NSl=NBl+np; X.tRoot.assign(NSl,-2); X.tDep.assign(NSl,0);
  // sources
  auto trace=[&](int l, int& root, int& depth)->string{ depth=0;
    while(true){ if(l==d.om){ root=0; return ""; } int j=cons[l]; if(j<0) return "relevant lead ends at non-om output";
      if(type[j]==0){ depth++; l=d.cs[j].hi; continue; }
      if(type[j]==1){ const C&c=d.cs[j]; int blue = e.red[c.a]? c.b : c.a; if(blue!=l) return "relevant into red input?"; root=1+ptP[j]; return ""; }
      return "relevant lead into branch node"; } };
  vector<double> kr(1+np,0); vector<int> cnt(1+np,0);
  for(int k=0;k<nc;k++){ if(type[k]==0) continue; int src = (type[k]==2) ? (aid[branchIdx[k]]-n) : (NBl+ptP[k]); int l=d.cs[k].lo;
    if(!e.rel[l]){ if(type[k]==2){ X.err="branch lo irrelevant"; return X; } X.tRoot[src]=-1; X.tDep[src]=0; X.f.nDead++; continue; }
    int r,dep; string er=trace(l,r,dep); if(!er.empty()){ X.err=er; return X; } X.tRoot[src]=r; X.tDep[src]=dep; kr[r]+=pow(2.0,-dep); cnt[r]++;
    if(type[k]==1) X.f.nPtSrcLive++; if(r>0 && dep==0) X.f.nPortDepth0++; X.f.maxDepth=max(X.f.maxDepth,dep); }
  for(int s=0;s<NSl;s++) if(X.tRoot[s]==-2){ X.err="unassigned source"; return X; }
  for(int r=0;r<=np;r++){ if(cnt[r]==0){ X.err="empty root"; return X; } if(fabs(kr[r]-1)>1e-12){ X.err="kraft!=1 at root"; return X; } }
  // features
  X.f.nPt=np; for(int k=0;k<nc;k++){ if(type[k]==0) X.f.nBlue++; if(type[k]==1){ if(ptNode[k]==rootNode) X.f.nPtRoot++; if(ptNode[k]<n) X.f.nPtLeaf++; } }
  for(int v=0;v<tot;v++) if(seg[v].size()>=2) X.f.ptsSameSeg++;
  X.ok=true; return X;
}
// ---------- check against abs5 code ----------
struct CheckRes { bool ok=true; string why; int formulaMax=-1; };
int lgOf(int n){ int lg=0; while((1<<lg)<n-1) lg++; return lg; }
void setupGlobals(int n, int Lv, const Extract& X){
  ::N=n; ::L=Lv; ::H=Lv-lgOf(n); ::T=::build(X.shape); ::TOT=2*n-1; ::curShape=X.shape;
  ::isAnc.assign(::TOT,vector<char>(::TOT,0)); for(int v=0;v<::TOT;v++){int u=v; while(u>=0){::isAnc[u][v]=1; u=::T.par[u];}}
  ::kseg=X.kseg;
}
// replicate enumK acceptance: does enumK's loop (with its break) reach this kseg?
bool enumKAccepts(){
  vector<int> tgt=::kseg; vector<int> ks(::TOT,0);
  for(int v=0;v<::TOT;v++){ for(int k=0;k<=tgt[v];k++){ ks[v]=k; bool ok=true;
      for(int x=0;x<::N&&ok;x++){ if(!::isAnc[v][x]) continue; int u=x,dd=0; while(u>=0){ if(u<=v) dd+=ks[u]; if(u>=::N) dd++; u=::T.par[u]; } if(dd>::H) ok=false; }
      if(!ok) return false; } }
  return true;
}
// per-pair formula costs (abs5 route()), with target assignment; requires runConfig setup done
bool formulaCosts(const Extract& X, vector<vector<int>>& fc){
  ::rootOf=X.tRoot; ::depOf=X.tDep; fc.assign(::N,vector<int>(::N,-1));
  for(int x=0;x<::N;x++){ ::curX=x; ::memoR.assign(::NS,-1); ::bad=false;
    for(int y=0;y<::N;y++) if(y!=x){ int c=::lcaOf(x,y); int r=::route(c-::N); if(::bad) return false; fc[x][y]=::delta[x]+::preF(y,c)+r; } }
  return true;
}
CheckRes check(int n, const Extract& X, const Eval& ered, int Lacc){
  CheckRes R;
  // (1) formula run with huge L: forced dfs must reach finish, formula == abs5-sim, per-pair == our simulation
  setupGlobals(n,1000,X); ::forced=true; ::tgtRoot=X.tRoot; ::tgtDep=X.tDep; ::failReason=""; ::tgtReachedFinish=false; ::tgtFeasible=false; ::tgtMaxcost=-1;
  long long sf0=::simFail; ::runConfig();
  if(!::tgtFeasible){ R.ok=false; R.why="formula-run not feasible: "+::failReason; return R; }
  if(::simFail!=sf0){ R.ok=false; R.why="abs5 simulate() mismatch in formula run"; return R; }
  R.formulaMax=::tgtMaxcost;
  vector<vector<int>> fc; if(!formulaCosts(X,fc)){ R.ok=false; R.why="formulaCosts bad"; return R; }
  for(int x=0;x<n;x++) for(int y=0;y<n;y++) if(x!=y){ int ax=X.leafMap[x], ay=X.leafMap[y]; if(fc[ax][ay]!=ered.cost[x][y]){ R.ok=false; R.why="per-pair formula "+to_string(fc[ax][ay])+" != sim "+to_string(ered.cost[x][y])+" at ("+to_string(x)+","+to_string(y)+")"; return R; } }
  if(R.formulaMax!=ered.p2){ R.ok=false; R.why="formula max != sim p2"; return R; }
  // (2) acceptance at L=Lacc
  setupGlobals(n,Lacc,X);
  if(::H<1){ R.ok=false; R.why="H<1"; return R; }
  { auto S=::shapes(n,::H); if(find(S.begin(),S.end(),X.shape)==S.end()){ R.ok=false; R.why="shape not in shapes(N,H)"; return R; } }
  if(!enumKAccepts()){ R.ok=false; R.why="enumK rejects kseg"; return R; }
  ::forced=true; ::tgtRoot=X.tRoot; ::tgtDep=X.tDep; ::failReason=""; ::tgtReachedFinish=false; ::tgtFeasible=false; ::tgtMaxcost=-1;
  sf0=::simFail; ::runConfig();
  if(!::tgtFeasible){ R.ok=false; R.why="acceptance failed at L="+to_string(Lacc)+": "+::failReason; return R; }
  if(::simFail!=sf0){ R.ok=false; R.why="abs5 simulate() mismatch in acceptance run"; return R; }
  if(::tgtMaxcost!=ered.p2){ R.ok=false; R.why="acceptance maxcost mismatch"; return R; }
  return R;
}
} // namespace aud
// ---------------- driver ----------------
using namespace aud;
struct Stats { long long tested=0, fail=0, extractFail=0, reduceFail=0; map<int,long long> byP2; set<string> structs; Feat agg; long long withPt=0, withPtRoot=0, withPtLeaf=0, withDead=0, withPtSrcLive=0, withPortD0=0, withSameSeg=0; };
Stats ST;
vector<string> failLog;
string netStr(int n, const vector<pair<int,int>>& cmp){ string s=to_string(n)+":"; for(auto&p:cmp) s+=" ("+to_string(p.first)+","+to_string(p.second)+")"; return s; }
void testNet(int n, const vector<pair<int,int>>& cmp, bool verbose=false){
  DNet d=fromStd(n,cmp); Eval e0=evalNet(d); if(!e0.top2) return;
  ST.tested++;
  DNet r=d; while(reduceOnce(r)); Eval er=evalNet(r);
  bool redOk = er.top2; for(int x=0;x<n&&redOk;x++) for(int y=0;y<n;y++) if(x!=y && er.cost[x][y]>e0.cost[x][y]) redOk=false;
  if(!redOk){ ST.reduceFail++; ST.fail++; failLog.push_back("REDUCE "+netStr(n,cmp)); return; }
  Extract X=extract(r);
  if(!X.ok){ ST.extractFail++; ST.fail++; failLog.push_back("EXTRACT("+X.err+") "+netStr(n,cmp)); return; }
  CheckRes c1=check(n,X,er,er.p2);
  if(!c1.ok){ ST.fail++; failLog.push_back("CHECK@red("+c1.why+") "+netStr(n,cmp)); return; }
  if(e0.p2!=er.p2){ CheckRes c2=check(n,X,er,e0.p2); if(!c2.ok){ ST.fail++; failLog.push_back("CHECK@orig("+c2.why+") "+netStr(n,cmp)); return; } }
  if(getenv("NEGTEST")){ CheckRes cn=check(n,X,er,er.p2-1); static map<string,int> rs; string k=cn.ok?"UNEXPECTED-ACCEPT":cn.why.substr(0,cn.why.find(" src")); k=k.substr(0,60); rs[k]++; if(cn.ok) failLog.push_back("NEG-ACCEPTED "+netStr(n,cmp)); if(ST.tested%200==0){ for(auto&kv:rs) fprintf(stderr,"NEG %s : %d\n",kv.first.c_str(),kv.second);} }
  ST.byP2[er.p2]++;
  string key=X.shape+"|"; for(int k:X.kseg) key+=to_string(k)+","; key+="|"; for(size_t i=0;i<X.tRoot.size();i++) key+=to_string(X.tRoot[i])+":"+to_string(X.tDep[i])+" ";
  ST.structs.insert(to_string(n)+"#"+key);
  if(X.f.nPt) ST.withPt++; if(X.f.nPtRoot) ST.withPtRoot++; if(X.f.nPtLeaf) ST.withPtLeaf++; if(X.f.nDead) ST.withDead++; if(X.f.nPtSrcLive) ST.withPtSrcLive++; if(X.f.nPortDepth0) ST.withPortD0++; if(X.f.ptsSameSeg) ST.withSameSeg++;
  if(verbose) printf("ok p2orig=%d p2red=%d shape=%s pts=%d\n",e0.p2,er.p2,X.shape.c_str(),X.f.nPt);
}
vector<pair<int,int>> randTop2(int n){ vector<pair<int,int>> c; while(!top2Std(n,c)){ int a=rnd(n), b=rnd(n); if(a==b) continue; if(a>b) swap(a,b); c.push_back({a,b}); } return c; }
vector<pair<int,int>> randSorter(int n){ vector<pair<int,int>> c; 
  auto sorts=[&](){ for(int m=0;m<(1<<n);m++){ int v=m; for(auto&p:c){ int a=(v>>p.first)&1, b=(v>>p.second)&1; if(a>b){ v^=(1<<p.first)|(1<<p.second);} } int k=__builtin_popcount(v); if(v!=(((1<<k)-1)<<(n-k))) return false; } return true; };
  while(!sorts()){ for(int t=0;t<5;t++){ int a=rnd(n), b=rnd(n); if(a==b) continue; if(a>b) swap(a,b); c.push_back({a,b}); } } return c; }
void minimize(int n, vector<pair<int,int>>& c, bool keepP2){ int p0=0; top2Std(n,c,&p0); bool ch=true;
  while(ch){ ch=false; vector<int> idx(c.size()); iota(idx.begin(),idx.end(),0); shuffle(idx.begin(),idx.end(),rng);
    vector<char> del(c.size(),0);
    for(int i: idx){ del[i]=1; vector<pair<int,int>> t; for(size_t j=0;j<c.size();j++) if(!del[j]) t.push_back(c[j]); int p; if(top2Std(n,t,&p) && (!keepP2 || p<=p0)) { ch=true; } else del[i]=0; }
    vector<pair<int,int>> t; for(size_t j=0;j<c.size();j++) if(!del[j]) t.push_back(c[j]); c=t; } }
string netStr(int n, const vector<pair<int,int>>& cmp);
int gBest=1000; vector<pair<int,int>> gBestNet;
// simulated annealing toward low p2
void saRun(int n, int target, long long steps, int maxLen, vector<vector<pair<int,int>>>& out, int maxOut){
  vector<pair<int,int>> cur=randTop2(n); int viol; int p=p2Std(n,cur,viol); double E=1000.0*viol+20*p+cur.size();
  for(long long it=0;it<steps && (int)out.size()<maxOut;it++){
    double Tm = 40.0*pow(0.5/40.0,(double)(it%200000)/200000.0);
    vector<pair<int,int>> nx=cur; int mv=rnd(100);
    auto rc=[&](){ int a=rnd(n), b=rnd(n); while(a==b) b=rnd(n); if(a>b) swap(a,b); return make_pair(a,b); };
    if(mv<35){ if((int)nx.size()<maxLen) nx.insert(nx.begin()+rnd(nx.size()+1),rc()); }
    else if(mv<70){ if(!nx.empty()) nx.erase(nx.begin()+rnd(nx.size())); }
    else if(mv<90){ if(!nx.empty()) nx[rnd(nx.size())]=rc(); }
    else { if(nx.size()>=2){ int i=rnd(nx.size()-1); swap(nx[i],nx[i+1]); } }
    int v2; int p2=p2Std(n,nx,v2); double E2=1000.0*v2+20*p2+nx.size();
    if(v2==0 && p2<gBest){ gBest=p2; gBestNet=nx; fprintf(stderr,"BEST p2=%d at it=%lld net=%s\n",p2,it,netStr(n,nx).c_str()); fflush(stderr); }
    if(E2<=E || exp((E-E2)/Tm) > (double)(rng()%1000000)/1e6){ cur=nx; E=E2; viol=v2; p=p2;
      if(viol==0 && p<=target){ out.push_back(cur); auto m=cur; minimize(n,m,true); out.push_back(m); } }
  }
}
int main(int argc,char**argv){
  if(argc<5){ fprintf(stderr,"usage: audit MODE N COUNT SEED [target] [steps]\n"); return 1; }
  string mode=argv[1]; int n=atoi(argv[2]); long long count=atoll(argv[3]); rng.seed(atoll(argv[4]));
  if(mode=="randmin"){ for(long long i=0;i<count;i++){ auto c=randTop2(n); testNet(n,c); minimize(n,c,false); testNet(n,c); } }
  else if(mode=="sortmin"){ for(long long i=0;i<count;i++){ auto c=randSorter(n); testNet(n,c); minimize(n,c,false); testNet(n,c); } }
  else if(mode=="sa"){ int target=atoi(argv[5]); long long steps=argc>6?atoll(argv[6]):2000000; vector<vector<pair<int,int>>> out;
    int perRun = getenv("PERRUN")? atoi(getenv("PERRUN")) : 20;
    for(long long i=0;i<count;i++){ out.clear(); saRun(n,target,steps,4*n+12,out,perRun); for(auto&c:out) testNet(n,c); } }
  else if(mode=="exh"){ int K=atoi(argv[5]); // all standard sequences of length <= K
    vector<pair<int,int>> pairs; for(int a=0;a<n;a++) for(int b=a+1;b<n;b++) pairs.push_back({a,b});
    vector<pair<int,int>> seq; long long nodesE=0;
    function<void()> rec=[&](){ nodesE++; if(top2Std(n,seq)) testNet(n,seq); if((int)seq.size()==K) return; for(auto&p:pairs){ seq.push_back(p); rec(); seq.pop_back(); } };
    rec(); printf("exh nodes=%lld\n",nodesE); }
  else if(mode=="file"){ // lines: n: (a,b) ...
    string line; while(getline(cin,line)){ if(line.empty()) continue; int nn; char colon; stringstream ss(line); ss>>nn>>colon; vector<pair<int,int>> c; char ch; int a,b; while(ss>>ch>>a>>ch>>b>>ch) c.push_back({a,b}); testNet(nn,c,true); } }
  printf("MODE=%s N=%d tested=%lld fail=%lld (reduceFail=%lld extractFail=%lld) distinctStructs=%zu\n",mode.c_str(),n,ST.tested,ST.fail,ST.reduceFail,ST.extractFail,ST.structs.size());
  printf("  byP2:"); for(auto&kv:ST.byP2) printf(" %d:%lld",kv.first,kv.second); printf("\n");
  printf("  features: withPt=%lld withPtRoot=%lld withPtLeaf=%lld withDeadPtSrc=%lld withLivePtSrc=%lld withPortDepth0=%lld withMultiPtSeg=%lld\n",ST.withPt,ST.withPtRoot,ST.withPtLeaf,ST.withDead,ST.withPtSrcLive,ST.withPortD0,ST.withSameSeg);
  if(mode=="sa") printf("  SA best p2 (top2-correct) = %d : %s\n",gBest,netStr(n,gBestNet).c_str());
  for(size_t i=0;i<failLog.size() && i<30;i++) printf("FAIL %s\n",failLog[i].c_str());
}

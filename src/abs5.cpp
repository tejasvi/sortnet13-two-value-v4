// Complete abstract-model search for top-2 networks:  is there a top-2-correct network on N channels with
// max_{x!=y} |W(x,y)| <= L ?   (|W| = comparators touched by the max (from x) or the second max (from y)).
// Structure: branch tree B of max paths (unordered shape), pass-through comparators on B's segments,
// and a blue forest routing the second max to o_m.  The blue forest is represented by (root, depth) per
// source (Kraft equality per root); every depth multiset with Kraft equality is realizable by a tree.
// Feasible assignments are re-checked by explicit circuit simulation.
#include <bits/stdc++.h>
using namespace std;
int N, L, H;
struct Tree { vector<int> lc, rc, par, depth; int root; };
map<pair<int,int>, vector<string>> memoShapes;
vector<string> shapes(int n, int h){
  auto key=make_pair(n,h); if(memoShapes.count(key)) return memoShapes[key];
  vector<string> res; if(n==1) res.push_back("L");
  else if(h>0){ set<string> seen; for(int a=1;a<=n/2;a++){ int b=n-a; auto A=shapes(a,h-1), Bv=shapes(b,h-1);
      for(auto&s:A) for(auto&t:Bv){ string u = s<t ? "("+s+t+")" : "("+t+s+")"; if(seen.insert(u).second) res.push_back(u);} } }
  return memoShapes[key]=res;
}
Tree T; int TOT;
Tree build(const string& s){
  Tree t; int tot=2*N-1; t.lc.assign(tot,-1); t.rc.assign(tot,-1); t.par.assign(tot,-1); t.depth.assign(tot,0);
  int leafCnt=0,intCnt=N; size_t pos=0;
  function<int()> rec=[&]()->int{ if(s[pos]=='L'){pos++; return leafCnt++;} pos++; int a=rec(); int b=rec(); pos++; int v=intCnt++; t.lc[v]=a;t.rc[v]=b;t.par[a]=v;t.par[b]=v; return v; };
  t.root=rec(); function<void(int,int)> dep=[&](int v,int d){t.depth[v]=d; if(t.lc[v]>=0){dep(t.lc[v],d+1);dep(t.rc[v],d+1);} }; dep(t.root,0);
  return t;
}
vector<int> kseg, delta; vector<vector<char>> isAnc;
struct PT{int v,i;}; vector<PT> pts; vector<vector<int>> ptOnSeg; int NP; // pass-throughs
// sources: index 0..NB-1 = branch nodes (internal nodes N..TOT-1), NB.. = pass-throughs
int NB, NS; vector<int> srcComp; // comp id: branch node id, or TOT+p
// roots: 0 = OM, 1+p = port of pass-through p, -1 = DEAD
vector<int> rootOf, depOf;
vector<vector<int>> slackCX; // [c][x]
int preF(int y,int c){ int cnt=0,v=y; while(v!=c){ cnt+=kseg[v]; int p=T.par[v]; if(p!=c) cnt++; v=p; } return cnt; }
int lcaOf(int x,int y){ int a=x; while(!isAnc[a][y]) a=T.par[a]; return a; }
int portCostX(int p,int x){ int v=pts[p].v; if(isAnc[v][x]) return 0; int cost=1+((int)ptOnSeg[v].size()-1-pts[p].i); int w=T.par[v]; while(w>=0 && !isAnc[w][x]){ cost+=1+(int)ptOnSeg[w].size(); w=T.par[w]; } return cost; }
int escNode(int p,int x){ int w=T.par[pts[p].v]; while(!isAnc[w][x]) w=T.par[w]; return w; }
// ---------- evaluation by route formula ----------
vector<int> memoR; int curX; bool bad;
int route(int s){ // s = source index
  if(memoR[s]>=0) return memoR[s]; if(memoR[s]==-2){bad=true;return 1000;} memoR[s]=-2;
  int r; int rt=rootOf[s];
  if(rt<0){ bad=true; r=1000; }
  else if(rt==0) r=depOf[s];
  else { int p=rt-1; int v=pts[p].v;
    if(isAnc[v][curX]) r=depOf[s]+route(NB+p);
    else { int w=escNode(p,curX); r=depOf[s]+portCostX(p,curX)+route(w-N); } }
  memoR[s]=r; return r;
}
bool evalFormula(int &maxcost){
  maxcost=0;
  for(int x=0;x<N;x++){ curX=x; memoR.assign(NS,-1); bad=false;
    for(int y=0;y<N;y++) if(y!=x){ int c=lcaOf(x,y); int r=route(c-N); if(bad) return false; int cost=delta[x]+preF(y,c)+r; maxcost=max(maxcost,cost); if(cost>L) return false; } }
  return true;
}
// ---------- explicit circuit simulation (independent check) ----------
// leads: integer ids; comparators: (in1,in2,outHigh,outLow)
struct Cmp{int a,b,hi,lo;};
bool simulate(int &maxcost, string &why){
  int nl=0; auto newLead=[&](){return nl++;};
  vector<Cmp> cmps; vector<int> inLead(N);
  for(int x=0;x<N;x++) inLead[x]=newLead();
  // red structure: process nodes bottom-up; segment of node v carries a lead upward
  vector<int> segTopLead(TOT,-1); // lead leaving the top of segment v (into parent / o_M)
  vector<int> ptBlueIn(NP,-1), ptLowLead(NP,-1), branchLow(TOT,-1);
  // we need blue inputs of pass-throughs before creating them: allocate placeholder leads for port inputs
  for(int p=0;p<NP;p++) ptBlueIn[p]=newLead();
  vector<int> ptCmpIdx(NP,-1);
  function<int(int)> up=[&](int v)->int{ // returns lead at top of segment v
    int lead;
    if(v<N) lead=inLead[v];
    else { int a=up(T.lc[v]), b=up(T.rc[v]); int hi=newLead(), lo=newLead(); cmps.push_back({a,b,hi,lo}); branchLow[v]=lo; lead=hi; }
    for(int id: ptOnSeg[v]){ int hi=newLead(), lo=newLead(); cmps.push_back({lead,ptBlueIn[id],hi,lo}); ptCmpIdx[id]=cmps.size()-1; ptLowLead[id]=lo; lead=hi; }
    return lead; };
  int oM=up(T.root);
  // blue forest: for each root, build a tree with the given depths (Kraft canonical): sort by depth, pair deepest
  vector<int> srcLead(NS); for(int c=N;c<TOT;c++) srcLead[c-N]=branchLow[c]; for(int p=0;p<NP;p++) srcLead[NB+p]=ptLowLead[p];
  int oM_m=-1; vector<int> rootLead(1+NP,-1);
  for(int r=0;r<=NP;r++){
    vector<pair<int,int>> mem; for(int s=0;s<NS;s++) if(rootOf[s]==r) mem.push_back({depOf[s],srcLead[s]});
    if(mem.empty()){ if(r>0){why="empty port";return false;} else {why="empty OM";return false;} }
    // build: repeatedly merge two deepest
    multimap<int,int,greater<int>> q; for(auto&m:mem) q.insert({m.first,m.second});
    while(q.size()>1){ auto it=q.begin(); int d1=it->first,l1=it->second; q.erase(it); it=q.begin(); int d2=it->first,l2=it->second; q.erase(it);
      if(d1!=d2){ why="kraft shape"; return false; }
      int hi=newLead(), lo=newLead(); cmps.push_back({l1,l2,hi,lo}); q.insert({d1-1,hi}); }
    if(q.begin()->first!=0){ why="kraft root"; return false; }
    rootLead[r]=q.begin()->second;
  }
  oM_m=rootLead[0];
  // connect port inputs: alias ptBlueIn[p] := rootLead[1+p]  (relabel leads)
  vector<int> alias(nl); iota(alias.begin(),alias.end(),0);
  for(int p=0;p<NP;p++) alias[ptBlueIn[p]]=rootLead[1+p];
  auto A=[&](int l){ while(alias[l]!=l) l=alias[l]; return l; };
  for(auto&c:cmps){ c.a=A(c.a); c.b=A(c.b); }
  // topological order of comparators by lead dependencies
  int nc=cmps.size(); vector<int> producer(nl,-1); for(int i=0;i<nc;i++){ producer[cmps[i].hi]=i; producer[cmps[i].lo]=i; }
  vector<int> indeg(nc,0); vector<vector<int>> succ(nc);
  for(int i=0;i<nc;i++) for(int l: {cmps[i].a,cmps[i].b}) if(producer[l]>=0){ succ[producer[l]].push_back(i); indeg[i]++; }
  vector<int> order; deque<int> dq; for(int i=0;i<nc;i++) if(!indeg[i]) dq.push_back(i);
  while(!dq.empty()){ int u=dq.front(); dq.pop_front(); order.push_back(u); for(int w:succ[u]) if(--indeg[w]==0) dq.push_back(w); }
  if((int)order.size()!=nc){ why="cycle"; return false; }
  maxcost=0;
  for(int x=0;x<N;x++) for(int y=0;y<N;y++) if(x!=y){
    vector<int> val(nl,0); val[inLead[x]]=2; val[inLead[y]]=1; int cost=0;
    for(int i: order){ auto&c=cmps[i]; int u=val[c.a], v=val[c.b]; if(u||v) cost++; val[c.hi]=max(u,v); val[c.lo]=min(u,v); }
    if(val[oM]!=2){ why="M not at oM"; return false; }
    if(val[oM_m]!=1){ why="m not at om"; return false; }
    maxcost=max(maxcost,cost);
  }
  return true;
}
// ---------- search ----------
vector<int> srcOrder; vector<double> kraft; vector<int> memCnt; vector<char> closedR;
long long leaves=0, feasible=0, simFail=0, nodes=0; string curShape;
vector<vector<int>> adjR; // red/port graph over comps [0..TOT+NP)
bool reach(int a,int b){ vector<char> vis(adjR.size(),0); vector<int> st={a}; vis[a]=1; while(!st.empty()){int u=st.back();st.pop_back(); if(u==b) return true; for(int w:adjR[u]) if(!vis[w]){vis[w]=1;st.push_back(w);} } return false; }
int maxDepthAllowed;
void finish(){
  leaves++;
  for(int r=0;r<=NP;r++){ if(memCnt[r]==0) return; if(memCnt[r]==1){ /* single member must have depth 0 */ }
    else if(fabs(kraft[r]-1.0)>1e-12) return; }
  // single members depth 0 check
  for(int s=0;s<NS;s++){ int r=rootOf[s]; if(r>=0 && memCnt[r]==1 && depOf[s]!=0) return; }
  int mc; if(!evalFormula(mc)) return;
  feasible++;
  int sc; string why; if(!simulate(sc,why) || sc!=mc){ simFail++; if(simFail<5) fprintf(stderr,"SIM MISMATCH formula=%d sim=%d why=%s shape=%s\n",mc,sc,why.c_str(),curShape.c_str()); }
  else if(feasible<=2){ fprintf(stderr,"  feasible: shape=%s maxcost=%d (sim ok)\n",curShape.c_str(),mc); }
}
void dfs(int idx){
  nodes++;
  if(idx==NS){ finish(); return; }
  int s=srcOrder[idx];
  bool isPt = s>=NB;
  if(isPt){ rootOf[s]=-1; depOf[s]=0; dfs(idx+1); }
  for(int r=0;r<=NP;r++){
    if(closedR[r]) continue;
    int comp=srcComp[s];
    if(r>0){ int pid=TOT+(r-1); if(reach(pid,comp)) continue; }
    for(int d=0; d<=maxDepthAllowed; d++){
      double w=pow(2.0,-d);
      if(d==0 && memCnt[r]>0) continue;           // depth 0 means sole member
      if(memCnt[r]>0 && kraft[r]+w>1.0+1e-12) continue;
      // budget pruning for branch sources
      if(!isPt){ int c=s+N; bool ok=true;
        for(int x=0;x<N && ok;x++){ int sl=slackCX[c][x]; if(sl>=1000) continue; int lb=d + (r>0? portCostX(r-1,x):0); if(lb>sl) ok=false; }
        if(!ok) continue; }
      rootOf[s]=r; depOf[s]=d; memCnt[r]++; kraft[r]+=w; bool wasClosed=closedR[r];
      if(d==0 || fabs(kraft[r]-1.0)<1e-12) closedR[r]=1;
      if(r>0) adjR[comp].push_back(TOT+(r-1));
      dfs(idx+1);
      if(r>0) adjR[comp].pop_back();
      closedR[r]=wasClosed; kraft[r]-=w; memCnt[r]--; rootOf[s]=-1;
    }
  }
}
set<string> seenCfg; long long configs=0;
string canonCfg(int v){ string me="k"+to_string(kseg[v]); if(T.lc[v]<0) return me+"L"; string a=canonCfg(T.lc[v]),b=canonCfg(T.rc[v]); if(b<a) swap(a,b); return me+"("+a+","+b+")"; }
void runConfig(){
  { string cf=canonCfg(T.root); if(!seenCfg.insert(cf).second) return; }
  pts.clear(); ptOnSeg.assign(TOT,{});
  for(int v=0;v<TOT;v++) for(int i=0;i<kseg[v];i++){ ptOnSeg[v].push_back(pts.size()); pts.push_back({v,i}); }
  NP=pts.size();
  delta.assign(N,0); for(int x=0;x<N;x++){ int v=x,d=0; while(v>=0){ d+=kseg[v]; if(v>=N) d++; v=T.par[v]; } delta[x]=d; if(d>H) return; }
  slackCX.assign(TOT, vector<int>(N,1000));
  for(int c=N;c<TOT;c++) for(int side=0;side<2;side++){ int A=side?T.rc[c]:T.lc[c], Bn=side?T.lc[c]:T.rc[c];
    int maxpre=0; for(int y=0;y<N;y++) if(isAnc[Bn][y]) maxpre=max(maxpre,preF(y,c));
    for(int x=0;x<N;x++) if(isAnc[A][x]){ slackCX[c][x]=L-delta[x]-maxpre; if(slackCX[c][x]<0) return; } }
  // (per-path Kraft pre-check removed: invalid when a route re-enters the max tree via a pass-through and escapes)
  configs++;
  NB=N-1; NS=NB+NP; srcComp.assign(NS,0); for(int c=N;c<TOT;c++) srcComp[c-N]=c; for(int p=0;p<NP;p++) srcComp[NB+p]=TOT+p;
  rootOf.assign(NS,-1); depOf.assign(NS,0); kraft.assign(1+NP,0); memCnt.assign(1+NP,0); closedR.assign(1+NP,0);
  adjR.assign(TOT+NP,{});
  for(int v=0;v<TOT;v++){ int prevComp=(v>=N)?v:-1; for(int id:ptOnSeg[v]){ int pc=TOT+id; if(prevComp>=0) adjR[prevComp].push_back(pc); prevComp=pc; } int p=T.par[v]; if(p>=0&&prevComp>=0) adjR[prevComp].push_back(p); }
  // order: branch sources by min slack ascending, then pass-throughs
  srcOrder.clear(); vector<pair<int,int>> bs; for(int c=N;c<TOT;c++){ int m=1000; for(int x=0;x<N;x++) m=min(m,slackCX[c][x]); bs.push_back({m,c-N}); }
  sort(bs.begin(),bs.end()); for(auto&b:bs) srcOrder.push_back(b.second); for(int p=0;p<NP;p++) srcOrder.push_back(NB+p);
  maxDepthAllowed=L;
  dfs(0);
}
void enumK(int v){
  if(v==TOT){ runConfig(); return; }
  for(int k=0;k<=H;k++){ kseg[v]=k; bool ok=true;
    for(int x=0;x<N&&ok;x++){ if(!isAnc[v][x]) continue; int u=x,d=0; while(u>=0){ if(u<=v) d+=kseg[u]; if(u>=N) d++; u=T.par[u]; } if(d>H) ok=false; }
    if(!ok) break; enumK(v+1); }
  kseg[v]=0;
}
int main(int argc,char**argv){
  N=atoi(argv[1]); L=atoi(argv[2]); int lg=0; while((1<<lg)<N-1) lg++; H=L-lg;
  if(H<1){ printf("N=%d L=%d H=%d : no shapes\nTOTAL configs=0 leaves=0 feasible=0 simfail=0\n",N,L,H); return 0; }
  auto S=shapes(N,H); printf("N=%d L=%d H=%d shapes=%zu\n",N,L,H,S.size()); fflush(stdout);
  for(auto&s:S){ T=build(s); TOT=2*N-1; curShape=s; isAnc.assign(TOT,vector<char>(TOT,0)); for(int v=0;v<TOT;v++){int u=v; while(u>=0){isAnc[u][v]=1; u=T.par[u];}}
    kseg.assign(TOT,0); long long f0=feasible,n0=nodes,c0=configs; enumK(0);
    printf("shape %s configs=%lld feasible=%lld nodes=%lld\n",s.c_str(),configs-c0,feasible-f0,nodes-n0); fflush(stdout); }
  printf("TOTAL configs=%lld leaves=%lld feasible=%lld simfail=%lld\n",configs,leaves,feasible,simFail);
}

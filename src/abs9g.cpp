// Complete abstract-model search for top-2 networks:  is there a top-2-correct network on N channels with
// max_{x!=y} |W(x,y)| <= L ?   (|W| = comparators touched by the max (from x) or the second max (from y)).
// Structure: branch tree B of max paths (unordered shape), pass-through comparators on B's segments,
// and a blue forest routing the second max to o_m.  The blue forest is represented by (root, depth) per
// source (Kraft equality per root); every depth multiset with Kraft equality is realizable by a tree.
// Feasible assignments are re-checked by explicit circuit simulation.
// abs9c: abs9m with the table of canonical strings replaced by an exact orbit-representative test (constant memory).
// abs9e: abs9c with the slack test (S3) and the orbit-representative test also applied during the enumeration.
// abs9f: abs9e with a table of port costs, a faster partial slack test, and CFGSPLIT=i/P, which splits the
//        enumeration of each shape among P processes (output line "shape S part=i/P ..."); CFGSPLIT2=j/Q splits
//        a part further among Q processes at the deeper level SPLITLEVEL2 (default 16; "part=i/P sub=j/Q");
//        DFSSPLIT=m/R splits the depth-first search of each configuration among R processes ("dsplit=m/R"), and
//        DFSSPLIT2=m2/R2 splits each of these parts further at a deeper level ("dsplit2=m2/R2").
// abs9g: abs9f with a symmetry reduction of the depth-first search (see buildSym below; SYMBREAK=0 turns it off).
//        Revision 2 evaluates (P3) by one inequality per ancestor and resumes the comparisons of the symmetry test
//        along each path; its output is identical to that of revision 1. Revisions 3, 4 and 5 add DFSSPLIT3,
//        DFSSPLIT4 and DFSSPLIT5, further levels of splitting of the depth-first search; without them, the output
//        is that of revision 2.
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
double pw2neg[64]; // pw2neg[k] = 2^-k exactly (filled in main)
vector<int> srcOrder; vector<double> kraft; vector<int> memCnt; vector<char> closedR;
long long leaves=0, feasible=0, simFail=0, nodes=0, configs=0; string curShape;
vector<vector<int>> adjR; // red/port graph over comps [0..TOT+NP)
bool reach(int a,int b){ vector<char> vis(adjR.size(),0); vector<int> st={a}; vis[a]=1; while(!st.empty()){int u=st.back();st.pop_back(); if(u==b) return true; for(int w:adjR[u]) if(!vis[w]){vis[w]=1;st.push_back(w);} } return false; }
int maxDepthAllowed;
void printOrbit(); extern int sbOrbit;
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
  if(sbOrbit) printOrbit();
}
vector<vector<int>> maxdSR; // [source][root] max allowed depth (-1 if impossible); pt sources: L
vector<int> lbMemo; int lbX; bool lbBad; long long lbCycle=0; // lbCycle counts re-entries (none occur under (b))
vector<vector<int>> pcTabG, escTab; // portCostX(p,x) and escNode(p,x) for x not below pts[p].v, per configuration
vector<long long> lbMemoStamp; long long lbStampCur=0; // lbMemo[s] is valid only if lbMemoStamp[s]==lbStampCur
int lbRoute(int s){ // lower bound on route_x(s) under the current partial assignment (unassigned -> 0)
  if(lbMemoStamp[s]!=lbStampCur){ lbMemoStamp[s]=lbStampCur; lbMemo[s]=-1; }
  if(lbMemo[s]>=0) return lbMemo[s]; if(lbMemo[s]==-2){ lbCycle++; return 0; } lbMemo[s]=-2;
  int rt=rootOf[s]; int r;
  if(rt<0){ if(s>=NB && rootOf[s]==-1 && depOf[s]==-7){ lbBad=true; r=1000; } else r=0; } // unassigned (DEAD marked separately)
  else if(rt==0) r=depOf[s];
  else { int p=rt-1; int v=pts[p].v; if(isAnc[v][lbX]) r=depOf[s]+lbRoute(NB+p); else { int w=escTab[p][lbX]; r=depOf[s]+pcTabG[p][lbX]+lbRoute(w-N); } }
  lbMemo[s]=r; return r;
}
vector<char> isDead;
// (P3): delta(x)+pre(y,c)+tau^-(c) <= L for all y with lca(x,y)=c is the single inequality tau^-(c) <= slackCX[c][x],
// since slackCX[c][x] = L - delta(x) - max over those y of pre(y,c). ancSlack[x] lists (c-N, slackCX[c][x]) for the
// internal ancestors c of x. (abs9g revision 2; revision 1 looped over all y, with the same verdicts.)
vector<vector<pair<int,int>>> ancSlack;
bool partialOK(){
  for(int x=0;x<N;x++){ lbX=x; lbStampCur++;
    for(auto&pr: ancSlack[x]) if(lbRoute(pr.first)>pr.second) return false; }
  return true;
}
double needMass(int idx){ double m=0; for(int j=idx;j<NS;j++){ int s=srcOrder[j]; if(s>=NB) continue; int best=-1; for(int r=0;r<=NP;r++){ if(closedR[r]) continue; best=max(best,maxdSR[s][r]); } if(best<0) return 1e9; m+=pw2neg[best]; } return m; }
double capacity(){ double c=0; for(int r=0;r<=NP;r++) if(!closedR[r]) c+=1.0-kraft[r]; return c; }
// ---------- symmetry reduction (abs9g) ----------
// For an internal node v whose two child subtrees have the same decorated canonical string (decStr includes the
// pass-through numbers of the two child segments), g_v is the automorphism of (B,k) that exchanges the two
// subtrees by a decoration-preserving isomorphism and fixes every other node. It maps branch sources to branch
// sources, the pass-through at position i of a segment to the pass-through at position i of the image segment,
// and ports accordingly (OM and DEAD fixed); an assignment a goes to g_v a with (g_v a)(g_v s) = (g_v rootOf(s),
// depOf(s)). Every test of the search is defined from (B,k) alone, so a and g_v a are feasible together. The
// search keeps only assignments with a <= g_v a for every such v, comparing the pairs (root, depth) of the sources
// in the order srcOrder lexicographically. The least member of each orbit under the group generated by the g_v
// satisfies all these inequalities, so a feasible assignment exists iff one is kept.
int symOn=1, sbOrbit=0;
struct Gen { vector<int> src, root; }; // src[s] = image of source s; root[r+1] = image of root r, r = -1..NP
vector<Gen> gens; vector<int> posOf; vector<string> dsMemo; vector<int> sbPos, sbRes;
void buildSym(){
  gens.clear(); posOf.assign(NS,0); for(int j=0;j<NS;j++) posOf[srcOrder[j]]=j;
  if(!symOn && !sbOrbit) return;
  dsMemo.assign(TOT,string());
  for(int v=0;v<TOT;v++){ string me="k"+to_string(kseg[v]); if(T.lc[v]<0) dsMemo[v]=me+"L"; else { const string &a=dsMemo[T.lc[v]], &b=dsMemo[T.rc[v]]; dsMemo[v]= b<a ? me+"("+b+","+a+")" : me+"("+a+","+b+")"; } }
  for(int v=N;v<TOT;v++){ int a=T.lc[v], b=T.rc[v]; if(dsMemo[a]!=dsMemo[b]) continue;
    vector<int> img(TOT); iota(img.begin(),img.end(),0);
    function<void(int,int)> iso=[&](int x,int y){ img[x]=y; img[y]=x; if(T.lc[x]<0){ if(T.lc[y]>=0){ fprintf(stderr,"iso leaf\n"); exit(3);} return; }
      int x1=T.lc[x],x2=T.rc[x],y1=T.lc[y],y2=T.rc[y];
      if(dsMemo[x1]==dsMemo[y1] && dsMemo[x2]==dsMemo[y2]){ iso(x1,y1); iso(x2,y2); }
      else if(dsMemo[x1]==dsMemo[y2] && dsMemo[x2]==dsMemo[y1]){ iso(x1,y2); iso(x2,y1); }
      else { fprintf(stderr,"iso mismatch\n"); exit(3); } };
    iso(a,b);
    for(int u=0;u<TOT;u++){ if(kseg[img[u]]!=kseg[u] || img[img[u]]!=u || (u!=T.root && T.par[img[u]]!=img[T.par[u]]) || ((img[u]<N)!=(u<N))){ fprintf(stderr,"not an automorphism\n"); exit(3); } }
    Gen g; g.src.assign(NS,0); g.root.assign(NP+2,0);
    vector<int> ptImg(NP); for(int p=0;p<NP;p++) ptImg[p]=ptOnSeg[img[pts[p].v]][pts[p].i];
    for(int s=0;s<NB;s++) g.src[s]=img[s+N]-N;
    for(int p=0;p<NP;p++) g.src[NB+p]=NB+ptImg[p];
    g.root[0]=-1; g.root[1]=0; for(int p=0;p<NP;p++) g.root[p+2]=1+ptImg[p];
    gens.push_back(g); }
  sbPos.assign((NS+1)*max<size_t>(gens.size(),1),0); sbRes.assign((NS+1)*max<size_t>(gens.size(),1),0);
}
// sources srcOrder[0..idx-1] are assigned; false iff some g_v already has g_v a <lex a for every completion
// The comparison for g_v is resumed where the parent node left it (sbPos, sbRes per depth): positions found equal
// stay equal along a path, and a decided comparison stays decided. (Revision 1 rescanned from position 0.)
bool sbOK(int idx){
  int G=gens.size(); if(G==0 || idx==0) return true;
  const int *pp=&sbPos[(idx-1)*G], *pr=&sbRes[(idx-1)*G]; int *cp=&sbPos[idx*G], *cr=&sbRes[idx*G];
  for(int gi=0;gi<G;gi++){
    cr[gi]=pr[gi]; cp[gi]=pp[gi];
    if(cr[gi]) continue;
    const Gen&g=gens[gi]; int j=cp[gi];
    for(;j<idx;j++){ int s=srcOrder[j], t=g.src[s]; if(posOf[t]>=idx) break;
      int ra=rootOf[s], da= ra<0? 0: depOf[s]; int rb=g.root[rootOf[t]+1], db= rootOf[t]<0? 0: depOf[t];
      if(ra==rb && da==db) continue;
      if(ra<rb || (ra==rb && da<db)){ cr[gi]=1; break; }
      return false; }
    cp[gi]=j; }
  return true;
}
// SBORBIT=1 (checking only): print the least member of the orbit of every feasible assignment
void printOrbit(){
  vector<pair<int,int>> a(NS); for(int s=0;s<NS;s++) a[s]={rootOf[s], rootOf[s]<0? 0: depOf[s]};
  set<vector<pair<int,int>>> seen; deque<vector<pair<int,int>>> q; seen.insert(a); q.push_back(a);
  while(!q.empty()){ auto x=q.front(); q.pop_front(); for(auto&g:gens){ vector<pair<int,int>> y(NS); for(int s=0;s<NS;s++) y[g.src[s]]={g.root[x[s].first+1], x[s].second}; if(seen.insert(y).second) q.push_back(y); } }
  vector<pair<int,int>> best; bool first=true;
  for(auto&x:seen){ vector<pair<int,int>> o(NS); for(int j=0;j<NS;j++) o[j]=x[srcOrder[j]]; if(first||o<best){ best=o; first=false; } }
  printf("ORB %s cfg=%lld size=%zu :",curShape.c_str(),configs,seen.size()); for(auto&p:best) printf(" %d,%d",p.first,p.second); printf("\n");
}
// DFSSPLIT=m/R splits the depth-first search of every configuration among R processes: the search subtrees at
// depth DFSSPLITDEPTH (default 3 sources assigned) are dealt out in turn, and process m explores those with
// sequence number = m mod R. The search above that depth is the same in all R processes, so their parts are
// disjoint and together cover each search; every process counts all configurations.
// DFSSPLIT2=m2/R2 splits each part of DFSSPLIT further among R2 processes in the same way at the deeper depth
// DFSSPLITDEPTH2 (default 8); its sequence numbers count only the subtrees inside the subtrees that the part owns.
// DFSSPLIT3=m3/R3 splits each part of DFSSPLIT2 further in the same way at the deeper depth DFSSPLITDEPTH3, and
// DFSSPLIT4=m4/R4 each part of DFSSPLIT3 at DFSSPLITDEPTH4, and DFSSPLIT5=m5/R5 each part of DFSSPLIT4 at DFSSPLITDEPTH5.
long long dsSeq=0, dsSeq2=0, dsSeq3=0, dsSeq4=0, dsSeq5=0;
int dsR=1, dsM=0, dsD=3, dsR2=1, dsM2=0, dsD2=8, dsR3=1, dsM3=0, dsD3=12, dsR4=1, dsM4=0, dsD4=16, dsR5=1, dsM5=0, dsD5=20;
void dfs(int idx){
  if(dsR>1 && idx==dsD && (dsSeq++ % dsR)!=dsM) return;
  if(dsR2>1 && idx==dsD2 && (dsSeq2++ % dsR2)!=dsM2) return;
  if(dsR3>1 && idx==dsD3 && (dsSeq3++ % dsR3)!=dsM3) return;
  if(dsR4>1 && idx==dsD4 && (dsSeq4++ % dsR4)!=dsM4) return;
  if(dsR5>1 && idx==dsD5 && (dsSeq5++ % dsR5)!=dsM5) return;
  nodes++;
  if(symOn && !sbOK(idx)) return;
  if(needMass(idx)>capacity()+1e-12) return;
  if(idx==NS){ finish(); return; }
  int s=srcOrder[idx];
  bool isPt = s>=NB;
  if(isPt){ rootOf[s]=-1; depOf[s]=0; dfs(idx+1); }
  for(int r=0;r<=NP;r++){
    if(closedR[r]) continue;
    int comp=srcComp[s];
    if(r>0){ int pid=TOT+(r-1); if(reach(pid,comp)) continue; }
    for(int d=0; d<=maxDepthAllowed; d++){
      double w=pw2neg[d];
      if(d==0 && memCnt[r]>0) continue;           // depth 0 means sole member
      if(memCnt[r]>0 && kraft[r]+w>1.0+1e-12) continue;
      // budget pruning for branch sources
      if(!isPt){ int c=s+N; bool ok=true;
        for(int x=0;x<N && ok;x++){ int sl=slackCX[c][x]; if(sl>=1000) continue; int lb=d + (r>0? portCostX(r-1,x):0); if(lb>sl) ok=false; }
        if(!ok) continue; }
      rootOf[s]=r; depOf[s]=d; memCnt[r]++; kraft[r]+=w; bool wasClosed=closedR[r];
      if(d==0 || fabs(kraft[r]-1.0)<1e-12) closedR[r]=1;
      if(r>0) adjR[comp].push_back(TOT+(r-1));
      if(partialOK()) dfs(idx+1);
      if(r>0) adjR[comp].pop_back();
      closedR[r]=wasClosed; kraft[r]-=w; memCnt[r]--; rootOf[s]=-1;
    }
  }
}
// Exact orbit representatives, without a table: a configuration (B,k) is processed iff at every node whose two
// child subtrees have the same undecorated shape, the decorated canonical string of the left child is <= that of
// the right child. Isomorphic sibling subtrees are built identically from the canonical shape string, so each
// orbit under the automorphisms of B has exactly one such member (abs9m kept the first member it met instead).
vector<string> shapeOf; bool repOK;
string shapeStr(int v){ if(T.lc[v]<0) return shapeOf[v]="L"; string a=shapeStr(T.lc[v]), b=shapeStr(T.rc[v]); if(b<a) swap(a,b); return shapeOf[v]="("+a+b+")"; }
string canonRep(int v){ string me="k"+to_string(kseg[v]); if(T.lc[v]<0) return me+"L"; string a=canonRep(T.lc[v]), b=canonRep(T.rc[v]); if(shapeOf[T.lc[v]]==shapeOf[T.rc[v]] && b<a) repOK=false; if(b<a) swap(a,b); return me+"("+a+","+b+")"; }
// CFGSPLIT=i/P splits the enumeration of each shape among P processes: the subtrees of the enumeration below
// level SPLITLEVEL (default 10, the first SPLITLEVEL pass-through numbers fixed) are dealt out in turn, and
// process i explores those with sequence number = i mod P. All processes walk the same levels above in the same
// order with the same tests, so the parts are disjoint and together cover the whole enumeration.
long long cfgSeq=0, cfgSeq2=0; int splitP=1, splitI=0, splitLevel=10, splitQ=1, splitJ=0, splitLevel2=16;
void runConfig(){
  { repOK=true; canonRep(T.root); if(!repOK) return; }
  pts.clear(); ptOnSeg.assign(TOT,{});
  for(int v=0;v<TOT;v++) for(int i=0;i<kseg[v];i++){ ptOnSeg[v].push_back(pts.size()); pts.push_back({v,i}); }
  NP=pts.size();
  delta.assign(N,0); for(int x=0;x<N;x++){ int v=x,d=0; while(v>=0){ d+=kseg[v]; if(v>=N) d++; v=T.par[v]; } delta[x]=d; if(d>H) return; }
  slackCX.assign(TOT, vector<int>(N,1000));
  for(int c=N;c<TOT;c++) for(int side=0;side<2;side++){ int A=side?T.rc[c]:T.lc[c], Bn=side?T.lc[c]:T.rc[c];
    int maxpre=0; for(int y=0;y<N;y++) if(isAnc[Bn][y]) maxpre=max(maxpre,preF(y,c));
    for(int x=0;x<N;x++) if(isAnc[A][x]){ slackCX[c][x]=L-delta[x]-maxpre; if(slackCX[c][x]<0) return; } }
  // Refined per-path Kraft pre-check (valid): for leaf x, if no sibling subtree S_c along x's root path contains a
  // pass-through, the leads lo(c), c on path(x), form an antichain in the max tree of C/x, so
  // sum_c 2^{-route_x(c)} <= 1 and route_x(c) <= slack(c,x).
  {
    vector<int> ptBelow(TOT,0); // pass-throughs on segments strictly inside subtree of v (including v's own segment)
    function<int(int)> cnt=[&](int v)->int{ int c=kseg[v]; if(T.lc[v]>=0){ c+=cnt(T.lc[v]); c+=cnt(T.rc[v]); } ptBelow[v]=c; return c; };
    cnt(T.root);
    for(int x=0;x<N;x++){
      bool clean=true; double sum=0; int prev=x, v=T.par[x];
      while(v>=0){ int other = T.lc[v]==prev? T.rc[v] : T.lc[v]; if(ptBelow[other]>0){ clean=false; break; } sum+=pow(2.0,-slackCX[v][x]); prev=v; v=T.par[v]; }
      if(clean && sum>1+1e-12) return;
    }
  }
  configs++;
  NB=N-1; NS=NB+NP; srcComp.assign(NS,0); for(int c=N;c<TOT;c++) srcComp[c-N]=c; for(int p=0;p<NP;p++) srcComp[NB+p]=TOT+p;
  rootOf.assign(NS,-1); depOf.assign(NS,0); kraft.assign(1+NP,0); memCnt.assign(1+NP,0); closedR.assign(1+NP,0);
  adjR.assign(TOT+NP,{});
  for(int v=0;v<TOT;v++){ int prevComp=(v>=N)?v:-1; for(int id:ptOnSeg[v]){ int pc=TOT+id; if(prevComp>=0) adjR[prevComp].push_back(pc); prevComp=pc; } int p=T.par[v]; if(p>=0&&prevComp>=0) adjR[prevComp].push_back(p); }
  // order: branch sources by min slack ascending, then pass-throughs
  srcOrder.clear(); vector<pair<int,int>> bs; for(int c=N;c<TOT;c++){ int m=1000; for(int x=0;x<N;x++) m=min(m,slackCX[c][x]); bs.push_back({m,c-N}); }
  sort(bs.begin(),bs.end()); for(auto&b:bs) srcOrder.push_back(b.second); for(int p=0;p<NP;p++) srcOrder.push_back(NB+p);
  maxDepthAllowed=L;
  maxdSR.assign(NS, vector<int>(1+NP,L));
  vector<vector<int>> pcTab(1+NP, vector<int>(N,0)); for(int r=1;r<=NP;r++) for(int x=0;x<N;x++) pcTab[r][x]=portCostX(r-1,x);
  for(int sidx=0;sidx<NB;sidx++){ int c=sidx+N; for(int r=0;r<=NP;r++){ int md=L; for(int x=0;x<N;x++){ int sl=slackCX[c][x]; if(sl>=1000) continue; md=min(md, sl-pcTab[r][x]); } maxdSR[sidx][r]= md<0? -1: md; } }
  ancSlack.assign(N,{}); for(int x=0;x<N;x++) for(int v=T.par[x]; v>=0; v=T.par[v]) ancSlack[x].push_back({v-N, slackCX[v][x]});
  lbMemo.assign(NS,-1); lbMemoStamp.assign(NS,-1);
  pcTabG.assign(NP,vector<int>(N,0)); escTab.assign(NP,vector<int>(N,0));
  for(int p=0;p<NP;p++) for(int x=0;x<N;x++) if(!isAnc[pts[p].v][x]){ pcTabG[p][x]=portCostX(p,x); escTab[p][x]=escNode(p,x); }
  buildSym();
  dfs(0);
}
// abs9e: two tests applied during the enumeration of the pass-through numbers, each of which removes only partial
// assignments that every completion fails at the same test in runConfig().
//  (a) slack (S3): when the subtree of an internal node v is complete, every internal c in it has its pre-values
//      final, and delta(x) only grows as nodes above v are assigned; so L - delta(x) - maxpre < 0 already fails.
//      The test is monotone in k(v) (larger k, larger delta), so the loop over k stops.
//  (b) orbit representative: when the second of two sibling subtrees with the same shape is complete (its root w is
//      the larger index), the comparison of their decorated canonical strings is final.
vector<vector<int>> pairsAt; // pairsAt[w] = left siblings u of w with the same undecorated shape
string decStr(int v){ string me="k"+to_string(kseg[v]); if(T.lc[v]<0) return me+"L"; string a=decStr(T.lc[v]), b=decStr(T.rc[v]); if(b<a) swap(a,b); return me+"("+a+","+b+")"; }
int deltaPartial(int x,int v){ int u=x,d=0; while(u>=0){ if(u<=v) d+=kseg[u]; if(u>=N) d++; u=T.par[u]; } return d; }
bool slackPartialOK(int v){
  int dp[64]; for(int x=0;x<N;x++) dp[x]= isAnc[v][x]? deltaPartial(x,v) : 0;
  for(int c=N;c<=v;c++){ if(!isAnc[v][c]) continue;
    for(int side=0;side<2;side++){ int A=side?T.rc[c]:T.lc[c], Bn=side?T.lc[c]:T.rc[c];
      int maxdp=0; for(int x=0;x<N;x++) if(isAnc[A][x]) maxdp=max(maxdp,dp[x]);
      int maxpre=0; for(int y=0;y<N;y++) if(isAnc[Bn][y]) maxpre=max(maxpre,preF(y,c));
      if(L-maxdp-maxpre<0) return false; } }
  return true;
}
void enumK(int v){
  if(splitP>1 && v==min(splitLevel,TOT-1) && (cfgSeq++ % splitP)!=splitI) return;
  if(splitQ>1 && v==min(splitLevel2,TOT-1) && (cfgSeq2++ % splitQ)!=splitJ) return;
  if(v==TOT){ runConfig(); return; }
  for(int k=0;k<=H;k++){ kseg[v]=k; bool ok=true;
    for(int x=0;x<N&&ok;x++){ if(!isAnc[v][x]) continue; int u=x,d=0; while(u>=0){ if(u<=v) d+=kseg[u]; if(u>=N) d++; u=T.par[u]; } if(d>H) ok=false; }
    if(!ok) break;
    if(v>=N && !slackPartialOK(v)) break;
    bool rep=true; for(int u: pairsAt[v]) if(decStr(v)<decStr(u)){ rep=false; break; }
    if(!rep) continue;
    enumK(v+1); }
  kseg[v]=0;
}
int main(int argc,char**argv){
  N=atoi(argv[1]); L=atoi(argv[2]); int lg=0; while((1<<lg)<N-1) lg++; H=L-lg;
  int shard = argc>4 ? atoi(argv[3]) : 0, nshards = argc>4 ? atoi(argv[4]) : 1;
  if(H<1){ printf("N=%d L=%d H=%d : no shapes\nTOTAL configs=0 leaves=0 feasible=0 simfail=0\n",N,L,H); return 0; }
  auto S=shapes(N,H); printf("N=%d L=%d H=%d shapes=%zu\n",N,L,H,S.size()); fflush(stdout);
  for(int k=0;k<64;k++) pw2neg[k]=ldexp(1.0,-k);
  if(getenv("SYMBREAK")) symOn=atoi(getenv("SYMBREAK"));
  if(getenv("SBORBIT")) sbOrbit=atoi(getenv("SBORBIT"));
  printf("SYMBREAK %d\n",symOn);
  if(getenv("SPLITLEVEL")) splitLevel=atoi(getenv("SPLITLEVEL"));
  if(getenv("DFSSPLITDEPTH")) dsD=atoi(getenv("DFSSPLITDEPTH"));
  if(getenv("DFSSPLITDEPTH2")) dsD2=atoi(getenv("DFSSPLITDEPTH2"));
  if(getenv("DFSSPLIT2")){ if(sscanf(getenv("DFSSPLIT2"),"%d/%d",&dsM2,&dsR2)!=2 || dsR2<1 || dsM2<0 || dsM2>=dsR2){ fprintf(stderr,"bad DFSSPLIT2\n"); return 2; } }
  if(getenv("DFSSPLIT")){ if(sscanf(getenv("DFSSPLIT"),"%d/%d",&dsM,&dsR)!=2 || dsR<1 || dsM<0 || dsM>=dsR){ fprintf(stderr,"bad DFSSPLIT\n"); return 2; } }
  if(dsR2>1 && (dsR<2 || dsD2<=dsD)){ fprintf(stderr,"DFSSPLIT2 needs DFSSPLIT and DFSSPLITDEPTH2 > DFSSPLITDEPTH\n"); return 2; }
  if(getenv("DFSSPLITDEPTH3")) dsD3=atoi(getenv("DFSSPLITDEPTH3"));
  if(getenv("DFSSPLIT3")){ if(sscanf(getenv("DFSSPLIT3"),"%d/%d",&dsM3,&dsR3)!=2 || dsR3<1 || dsM3<0 || dsM3>=dsR3){ fprintf(stderr,"bad DFSSPLIT3\n"); return 2; } }
  if(dsR3>1 && (dsR2<2 || dsD3<=dsD2)){ fprintf(stderr,"DFSSPLIT3 needs DFSSPLIT2 and DFSSPLITDEPTH3 > DFSSPLITDEPTH2\n"); return 2; }
  if(getenv("DFSSPLITDEPTH4")) dsD4=atoi(getenv("DFSSPLITDEPTH4"));
  if(getenv("DFSSPLIT4")){ if(sscanf(getenv("DFSSPLIT4"),"%d/%d",&dsM4,&dsR4)!=2 || dsR4<1 || dsM4<0 || dsM4>=dsR4){ fprintf(stderr,"bad DFSSPLIT4\n"); return 2; } }
  if(dsR4>1 && (dsR3<2 || dsD4<=dsD3)){ fprintf(stderr,"DFSSPLIT4 needs DFSSPLIT3 and DFSSPLITDEPTH4 > DFSSPLITDEPTH3\n"); return 2; }
  if(getenv("DFSSPLITDEPTH5")) dsD5=atoi(getenv("DFSSPLITDEPTH5"));
  if(getenv("DFSSPLIT5")){ if(sscanf(getenv("DFSSPLIT5"),"%d/%d",&dsM5,&dsR5)!=2 || dsR5<1 || dsM5<0 || dsM5>=dsR5){ fprintf(stderr,"bad DFSSPLIT5\n"); return 2; } }
  if(dsR5>1 && (dsR4<2 || dsD5<=dsD4)){ fprintf(stderr,"DFSSPLIT5 needs DFSSPLIT4 and DFSSPLITDEPTH5 > DFSSPLITDEPTH4\n"); return 2; }
  if(getenv("SPLITLEVEL2")) splitLevel2=atoi(getenv("SPLITLEVEL2"));
  if(getenv("CFGSPLIT2")){ if(sscanf(getenv("CFGSPLIT2"),"%d/%d",&splitJ,&splitQ)!=2 || splitQ<1 || splitJ<0 || splitJ>=splitQ){ fprintf(stderr,"bad CFGSPLIT2\n"); return 2; } }
  if(getenv("CFGSPLIT")){ if(sscanf(getenv("CFGSPLIT"),"%d/%d",&splitI,&splitP)!=2 || splitP<1 || splitI<0 || splitI>=splitP){ fprintf(stderr,"bad CFGSPLIT\n"); return 2; } }
  set<string> skip; if(getenv("SKIPFILE")){ ifstream sf(getenv("SKIPFILE")); string w; while(sf>>w) skip.insert(w); }
  int si=-1;
  for(auto&s:S){ si++; if(si%nshards!=shard) continue; if(skip.count(s)) continue; T=build(s); shapeOf.assign(2*N-1,string()); shapeStr(T.root); TOT=2*N-1; pairsAt.assign(TOT,{}); for(int v=N;v<TOT;v++) if(shapeOf[T.lc[v]]==shapeOf[T.rc[v]]) pairsAt[T.rc[v]].push_back(T.lc[v]); curShape=s; isAnc.assign(TOT,vector<char>(TOT,0)); for(int v=0;v<TOT;v++){int u=v; while(u>=0){isAnc[u][v]=1; u=T.par[u];}}
    kseg.assign(TOT,0); cfgSeq=0; cfgSeq2=0; dsSeq=0; dsSeq2=0; dsSeq3=0; dsSeq4=0; dsSeq5=0; long long f0=feasible,n0=nodes,c0=configs; enumK(0);
    string lab; if(splitP>1) lab+=" part="+to_string(splitI)+"/"+to_string(splitP); if(splitQ>1) lab+=" sub="+to_string(splitJ)+"/"+to_string(splitQ);
    if(dsR>1) lab+=" dsplit="+to_string(dsM)+"/"+to_string(dsR)+" depth="+to_string(dsD);
    if(dsR2>1) lab+=" dsplit2="+to_string(dsM2)+"/"+to_string(dsR2)+" depth2="+to_string(dsD2);
    if(dsR3>1) lab+=" dsplit3="+to_string(dsM3)+"/"+to_string(dsR3)+" depth3="+to_string(dsD3);
    if(dsR4>1) lab+=" dsplit4="+to_string(dsM4)+"/"+to_string(dsR4)+" depth4="+to_string(dsD4);
    if(dsR5>1) lab+=" dsplit5="+to_string(dsM5)+"/"+to_string(dsR5)+" depth5="+to_string(dsD5);
    printf("shape %s%s configs=%lld feasible=%lld nodes=%lld\n",s.c_str(),lab.c_str(),configs-c0,feasible-f0,nodes-n0); fflush(stdout); }
  printf("TOTAL configs=%lld leaves=%lld feasible=%lld simfail=%lld\n",configs,leaves,feasible,simFail);
  if(lbCycle) fprintf(stderr,"lbRoute re-entries: %lld\n",lbCycle);
}

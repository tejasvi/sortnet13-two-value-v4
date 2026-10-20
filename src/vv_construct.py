# Construct Van Voorhis's "loser tournament" top-2 network for N leaves with an f-optimal branch tree,
# then verify p2 by explicit simulation.  Gives the upper bound P(2,N) <= ceil(log2 F(N)).
import sys, math, itertools, heapq
N=int(sys.argv[1])
# enumerate trees with (height, f) pareto, keep actual trees
from functools import lru_cache
best={1:[(0,0,'L')]}
def pareto(c):
    c=sorted(c,key=lambda t:(t[0],t[1])); out=[]; b=None
    for h,f,t in c:
        if b is None or f<b: out.append((h,f,t)); b=f
    return out
for n in range(2,N+1):
    cand=[]
    for a in range(1,n//2+1):
        for hl,fl,tl in best[a]:
            for hr,fr,tr in best[n-a]:
                cand.append((1+max(hl,hr),2**(1+hl+hr)+2*fl+2*fr,(tl,tr)))
    best[n]=pareto(cand)
h,F,tree=min(best[N],key=lambda t:t[1])
# build circuit: leads are ints; comparators (a,b,hi,lo)
leads=0
def nl():
    global leads; leads+=1; return leads-1
inputs=[]; cmps=[]; lowsrc=[]  # (lead, a(c))
def build(t,depth):
    # returns (lead, height lp)
    if t=='L':
        l=nl(); inputs.append(l); return l,0
    (L,R)=t
    a,ha=build(L,depth+1); b,hb=build(R,depth+1)
    hi,lo=nl(),nl(); cmps.append((a,b,hi,lo))
    lowsrc.append((lo, ha+hb+depth+1))
    return hi, 1+max(ha,hb)
oM,_=build(tree,0)
# second tournament: Huffman (1+max) over a(c): merge two smallest values
heap=[(ac,i,l) for i,(l,ac) in enumerate(lowsrc)]; heapq.heapify(heap); cnt=len(heap)
while len(heap)>1:
    a1,_,l1=heapq.heappop(heap); a2,_,l2=heapq.heappop(heap)
    hi,lo=nl(),nl(); cmps.append((l1,l2,hi,lo)); cnt+=1
    heapq.heappush(heap,(max(a1,a2)+1,cnt,hi))
om=heap[0][2]
# simulate (cmps already in topological order by construction)
p2=0
for x in range(N):
    for y in range(N):
        if x==y: continue
        val=[0]*leads; val[inputs[x]]=2; val[inputs[y]]=1; cost=0
        for (a,b,hi,lo) in cmps:
            u,v=val[a],val[b]
            if u or v: cost+=1
            val[hi]=max(u,v); val[lo]=min(u,v)
        assert val[oM]==2 and val[om]==1, "not top-2 correct"
        p2=max(p2,cost)
print(f"N={N} F={F} ceil(log2 F)={math.ceil(math.log2(F))} comparators={len(cmps)} simulated p2={p2}")

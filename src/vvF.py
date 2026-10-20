# Van Voorhis F(N) = min over full binary trees B with N leaves of f(B) = sum_c 2^{a(c)},
# a(c) = lp(L(c)) + lp(R(c)) + depth(c) + 1. Recursion: f(B) = 2^{1+lp(L)+lp(R)} + 2 f(L) + 2 f(R).
# Track (height, f) Pareto per leaf count.
import math, functools
def pareto(pairs):
    pairs=sorted(set(pairs)); out=[]; best=None
    for h,f in pairs:
        if best is None or f<best: out.append((h,f)); best=f
    return out
P={1:[(0,0)]}
for n in range(2,33):
    cand=[]
    for nl in range(1,n//2+1):
        nr=n-nl
        for hl,fl in P[nl]:
            for hr,fr in P[nr]:
                cand.append((1+max(hl,hr), 2**(1+hl+hr)+2*fl+2*fr))
    P[n]=pareto(cand)
for n in range(2,33):
    F=min(f for h,f in P[n]); print(n,F,math.ceil(math.log2(F)) if F>0 else 0)

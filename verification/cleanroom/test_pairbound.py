import sys, time
import gm
from sim import trees
# check: placements_pairbound(B,L) == {uc in placements(B,L) : all D(c) <= L}
for N in range(3, 8):
    for L in range(2, 8):
        for B in trees(N):
            A = set(tuple(sorted(d.items())) for d in gm.placements_pairbound(B, L))
            Bs = set()
            for uc in gm.placements(B, L):
                mt = gm.MT(B, uc)
                if all(v <= L for v in mt.D().values()):
                    Bs.add(tuple(sorted(uc.items())))
            assert A == Bs, (N, L, B, len(A), len(Bs))
    print("N", N, "pairbound enumeration == filtered path-bound enumeration, L=2..7", flush=True)

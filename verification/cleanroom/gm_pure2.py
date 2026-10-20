"""Pure GM search (no Kraft-over-runs condition): placements limited only by
D(c) <= L (trivially necessary), then exact spec search."""
import sys, time
import gm
N, L = int(sys.argv[1]), int(sys.argv[2])
t0 = time.time()
st = {}
r = gm.gm_feasible_pure2(N, L, stats=st)
print(f"GM-pure2 N={N} L={L}: {'FEASIBLE' if r else 'INFEASIBLE'}  (B,U) examined={st['count'][0]} time={time.time()-t0:.2f}s", flush=True)
if r:
    print("  B =", r[0], "unary =", r[1])

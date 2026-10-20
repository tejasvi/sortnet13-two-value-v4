"""Random near-optimal networks from randomized plain brute force (no Kraft
prune, so no bias from the lemma under test), checked with extract.analyse."""
import subprocess, sys
from sim import simulate
import extract
P = {3: 3, 4: 4, 5: 6, 6: 6, 7: 7, 8: 7}
Ns = [int(a) for a in sys.argv[1].split(',')]
seeds = range(int(sys.argv[2]), int(sys.argv[3]))
stats = dict(n=0, unary=0, graft=0, knock=0)
for N in Ns:
    for dL in (0, 1, 2):
        L = P[N] + dL
        for s in seeds:
            out = subprocess.run(['./bf2', str(N), str(L), '-seed', str(s)], capture_output=True, text=True, timeout=3000).stdout
            w = [l for l in out.splitlines() if l.startswith('witness:')]
            assert w, out
            net = [tuple(map(int, t.split(','))) for t in w[0].split()[1:]]
            ok, oM, om, cost = simulate(net, N)
            assert ok and max(cost.values()) <= L
            r = extract.analyse(net, N, check_spec=True, check_prefix=True)
            stats['n'] += 1
            stats['unary'] += r['unary'] > 0
            stats['graft'] += r['graft'] > 0
            stats['knock'] += r['knock'] > 0
print("N", Ns, "seeds", seeds, stats, "ALL CHECKS PASSED")

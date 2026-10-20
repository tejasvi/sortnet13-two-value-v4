import sys, re
from sim import simulate
for fn in sys.argv[1:]:
    lines = open(fn).read().splitlines()
    if not lines: print(fn, "EMPTY"); continue
    m = re.match(r"N=(\d+) L=(\d+)", lines[0]); N, L = int(m.group(1)), int(m.group(2))
    w = [l for l in lines if l.startswith("witness:")]
    if not w: print(fn, lines[0]); continue
    net = [tuple(map(int, t.split(","))) for t in w[0].split()[1:]]
    ok, oM, om, cost = simulate(net, N)
    print(f"{fn}: N={N} L={L} comparators={len(net)} top2ok={ok} oM={oM} om={om} p2={max(cost.values())}")

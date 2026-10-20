#!/usr/bin/env python3
"""Checks the logs of the release and prints the numbers quoted in the paper.

  python3 -I scripts/check_logs.py          (from the root of the repository)

1. logs/search/*.log: each run has a TOTAL line and exit status 0; the lower-bound runs report no feasible
   configuration; no run reports a simulation mismatch; abs5 and abs9 report the same number of feasible
   configurations wherever both were run.
2. logs/F.txt and logs/upper.txt: F(N) for N <= 32, and the simulated cost of each upper-bound network equals
   ceil(log2 F(N)).
Exits with status 1 if any check fails.
"""
import glob, math, os, re, sys

os.chdir(os.path.join(os.path.dirname(os.path.abspath(__file__)), ".."))
ok = True


def fail(msg):
    global ok
    ok = False
    print("FAIL:", msg)


# F(N) from logs/F.txt
F = {}
for line in open("logs/F.txt"):
    n, f, c = map(int, line.split())
    F[n] = f
    if c != math.ceil(math.log2(f)):
        fail(f"F.txt: ceil(log2 F({n}))")
P = {n: math.ceil(math.log2(F[n])) for n in F}
print("F(N), N=2..32:", " ".join(f"{n}:{F[n]}" for n in sorted(F)))

# upper-bound networks
for line in open("logs/upper.txt"):
    m = re.match(r"N=(\d+) F=(\d+) ceil\(log2 F\)=(\d+) comparators=(\d+) simulated p2=(\d+)", line)
    n, f, c, comps, p2 = map(int, m.groups())
    if f != F[n] or c != P[n] or p2 != P[n] or comps != 2 * n - 3:
        fail(f"upper.txt: N={n}")
print("upper-bound networks: N=2..32 simulated, p2 = ceil(log2 F(N)), 2N-3 comparators:",
      len(open("logs/upper.txt").read().split("\n")) - 1, "lines")


def parse(path):
    t = open(path).read()
    r = {"path": path}
    m = re.search(r"^N=(\d+) L=(\d+) H=(-?\d+)(?: shapes=(\d+))?", t, re.M)
    r["N"], r["L"], r["H"] = int(m.group(1)), int(m.group(2)), int(m.group(3))
    r["shapes"] = int(m.group(4)) if m.group(4) else 0
    r["shape_lines"] = re.findall(r"^shape (\S+) configs=(\d+) feasible=(\d+) nodes=(\d+)$", t, re.M)
    m = re.search(r"^TOTAL configs=(\d+) leaves=(\d+) feasible=(\d+)(?: simfail=(\d+))?$", t, re.M)
    r["total"] = tuple(int(g) if g else 0 for g in m.groups()) if m else None
    m = re.search(r"^WALL ([\d.]+) s$", t, re.M)
    r["wall"] = float(m.group(1)) if m else None
    m = re.findall(r"^EXIT (\d+)$", t, re.M)
    r["exit"] = int(m[-1]) if m else None
    r["nodes"] = sum(int(x[3]) for x in r["shape_lines"])
    return r


runs = {}
for path in sorted(glob.glob("logs/search/*.log")):
    prog = os.path.basename(path).split("_")[0]
    r = parse(path)
    runs[(prog, r["N"], r["L"])] = r
    if r["total"] is None or r["exit"] != 0:
        fail(f"{path}: incomplete")
    elif r["total"][3] != 0:
        fail(f"{path}: simulation mismatch")
    if r["shapes"] != len(r["shape_lines"]):
        fail(f"{path}: {r['shapes']} shapes announced, {len(r['shape_lines'])} result lines")

print("\nLower-bound runs at L = ceil(log2 F(N)) - 1 (no feasible configuration):")
print(f"{'prog':5} {'N':>3} {'L':>3} {'H':>3} {'shapes':>7} {'configs':>9} {'leaves':>7} {'nodes':>10} {'wall s':>7}")
for (prog, n, L), r in sorted(runs.items(), key=lambda kv: (kv[0][1], kv[0][0])):
    if L != P[n] - 1:
        continue
    if r["total"] and r["total"][2] != 0:
        fail(f"{r['path']}: feasible configuration at L = P - 1")
    c, lv, fe, sf = r["total"]
    print(f"{prog:5} {n:3} {L:3} {r['H']:3} {r['shapes']:7} {c:9} {lv:7} {r['nodes']:10} {r['wall']:7.2f}")

print("\nRuns at L = ceil(log2 F(N)) (feasible configurations, each rebuilt and simulated):")
for (prog, n, L), r in sorted(runs.items(), key=lambda kv: (kv[0][1], kv[0][0])):
    if L != P[n]:
        continue
    c, lv, fe, sf = r["total"]
    if fe == 0:
        fail(f"{r['path']}: no feasible configuration at L = P")
    print(f"{prog:5} N={n:2} L={L:2} feasible={fe} simfail={sf} wall={r['wall']:.2f}s")
simulated = {p: sum(r["total"][2] for (q, n, L), r in runs.items() if q == p) for p in ("abs5", "abs9")}
print("feasible configurations simulated:", simulated)

both = sorted({(n, L) for (p, n, L) in runs} & {(n, L) for (p, n, L) in runs if p == "abs5"})
for (n, L) in both:
    a, b = runs.get(("abs5", n, L)), runs.get(("abs9", n, L))
    if a and b and a["total"][2] != b["total"][2]:
        fail(f"abs5 and abs9 disagree at N={n} L={L}")
print("abs5 and abs9 agree on the feasible count at (N, L) =",
      ", ".join(f"({n},{L})" for (n, L) in both if ("abs9", n, L) in runs))


print("\nALL CHECKS PASSED" if ok else "\nSOME CHECKS FAILED")
sys.exit(0 if ok else 1)

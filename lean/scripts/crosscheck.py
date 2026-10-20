#!/usr/bin/env python3
"""Cross-check the Lean definitions (S13/Defs.lean: eval, runInput, W, Top2Correct; S13Comp: stepC)
against the clean-room Python simulator sim.py and the state step of bf2.cpp
(scripts/bf2_fstate.cpp).

Usage: crosscheck.py <lean crosscheck exe> <bf2_fstate exe> <seed> <count> [cleanroom dir]
The clean-room directory holds sim.py and networks.txt; the default is ../verification/cleanroom
relative to the Lean project, which is where it sits in the release repository.
"""
import itertools, os, random, re, subprocess, sys

lean_exe, cpp_exe, seed, count = sys.argv[1], sys.argv[2], int(sys.argv[3]), int(sys.argv[4])
lean_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
cleanroom = sys.argv[5] if len(sys.argv) > 5 else os.path.join(lean_root, '..', 'verification', 'cleanroom')
sys.path.insert(0, cleanroom)
from sim import simulate  # token simulation, clean-room implementation

rng = random.Random(seed)

known = {}  # top-two correct generalized networks from networks.txt
lines = open(os.path.join(cleanroom, 'networks.txt')).read().split('\n')
for i, l in enumerate(lines):
    m = re.match(r'N=(\d+) P2=(\d+) comparators=\d+ oM=(\d+) om=(\d+)', l)
    if m:
        N, p2, oM, om = map(int, m.groups())
        comps = [tuple(map(int, c.split(','))) for c in re.findall(r'\((\d+,\d+)\)', lines[i + 1])]
        known[N] = (comps, oM, om)

def rand_comp(N):
    a, b = rng.sample(range(N), 2)
    return (a, b)

def gen():
    kind = rng.random()
    N = rng.randint(3, 8)
    if kind < 0.4:  # random generalized network
        return N, [rand_comp(N) for _ in range(rng.randint(0, 30))]
    # random prefix + relabeled known top-two network + suffix avoiding the outputs
    comps, oM, om = known[N]
    perm = list(range(N)); rng.shuffle(perm)
    T = [(perm[a], perm[b]) for a, b in comps]
    oM2, om2 = perm[oM], perm[om]
    pre = [rand_comp(N) for _ in range(rng.randint(0, 12))]
    rest = [c for c in range(N) if c not in (oM2, om2)]
    suf = []
    if len(rest) >= 2:
        suf = [tuple(rng.sample(rest, 2)) for _ in range(rng.randint(0, 6))]
    net = pre + T + suf
    if kind < 0.55 and net:  # perturb: may break top-two correctness
        i = rng.randrange(len(net)); net[i] = rand_comp(N)
    return N, net

nets = [gen() for _ in range(count)]
# exhaustive small cases
for N, Lmax in ((3, 4), (4, 3)):
    pairs = [(a, b) for a in range(N) for b in range(N) if a != b]
    for L in range(Lmax + 1):
        for net in itertools.product(pairs, repeat=L):
            nets.append((N, list(net)))

inp = ''.join(f"{N} {' '.join(f'{a},{b}' for a, b in net)}\n" for N, net in nets)
lean_out = subprocess.run([lean_exe], input=inp, capture_output=True, text=True, check=True).stdout.split('\n')
cpp_out = subprocess.run([cpp_exe], input=inp, capture_output=True, text=True, check=True).stdout.split('\n')

bad = 0; ntop2 = 0
for k, (N, net) in enumerate(nets):
    ok, oM, om, cost = simulate(net, N)
    ntop2 += ok
    W = [cost[(x, y)] for x in range(N) for y in range(N) if x != y]
    F = [0] * (N * N)
    for x in range(N):
        for y in range(N):
            if x == y: continue
            pM, pm, c = x, y, 0
            for lo, hi in net:
                iM, im = pM in (lo, hi), pm in (lo, hi)
                if iM or im:
                    c += 1
                    if iM and im: pM, pm = hi, lo
                    elif iM: pM = hi
                    else: pm = hi
            F[pM * N + pm] = max(F[pM * N + pm], c + 1)
    exp = f"top2={1 if ok else 0} W={' '.join(map(str, W))} F={' '.join(map(str, F))}"
    expF = ' '.join(map(str, F))
    if lean_out[k] != exp or cpp_out[k] != expF:
        bad += 1
        if bad <= 5:
            print('MISMATCH', N, net); print(' lean', lean_out[k]); print(' cpp ', cpp_out[k]); print(' py  ', exp)
print(f"seed={seed} networks={len(nets)} top2_correct={ntop2} mismatches={bad}")

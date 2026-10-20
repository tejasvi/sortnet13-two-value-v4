#!/usr/bin/env python3
"""abs9g against abs9f, on the 22 runs of abs9 in logs/search/:
(1) abs9g with SYMBREAK=0 prints the same shape lines and TOTAL line as abs9f;
(2) with the symmetry test (SYMBREAK=1), the same numbers of skeletons for each shape, feasible configurations
    for the same shapes, and no mismatch in the simulation (S6);
(3) at the 9 levels with feasible configurations, the classes of feasible assignments under the group generated
    by the automorphisms g_v (each printed as its least member by SBORBIT=1) are the same with and without the
    symmetry test, for each skeleton."""
import glob
import os
import re

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
D = os.path.join(ROOT, "verification/n28")


def lines(fn):
    return [l for l in open(fn) if l.startswith(("shape", "TOTAL"))]


def parse(fn):
    sh, tot = {}, None
    for l in open(fn):
        m = re.match(r"shape (\S+) configs=(\d+) feasible=(\d+) nodes=(\d+)$", l.strip())
        if m:
            sh[m.group(1)] = tuple(int(x) for x in m.groups()[1:])
        m = re.match(r"TOTAL configs=(\d+) leaves=(\d+) feasible=(\d+) simfail=(\d+)$", l.strip())
        if m:
            tot = tuple(int(x) for x in m.groups())
    return sh, tot


def orbits(fn):
    res = set()
    for l in open(fn):
        if l.startswith("ORB ") and " : " in l:
            head, rest = l.rstrip("\n").split(" : ", 1)
            res.add(head.split(" size=")[0] + " : " + rest)
    return res


def key(f):
    return [int(x) for x in re.findall(r"\d+", os.path.basename(f))]


ok = True
for g in sorted(glob.glob(os.path.join(ROOT, "logs/search/abs9_N*_L*.log")), key=key):
    nl = os.path.basename(g)[len("abs9_"):]
    f0, f1 = os.path.join(D, "abs9g", "s0_" + nl), os.path.join(D, "abs9g", "s1_" + nl)
    same0 = lines(f0) == lines(os.path.join(D, "abs9f_vs_abs9", "abs9f_" + nl))
    s0, t0 = parse(f0)
    s1, t1 = parse(f1)
    cfg = set(s0) == set(s1) and all(s0[s][0] == s1[s][0] for s in s0)
    feas = all((s0[s][1] > 0) == (s1[s][1] > 0) for s in s0)
    good = same0 and cfg and feas and t1 is not None and t1[3] == 0
    ok &= good
    print(f"{nl[:-4]:8s} (1) SYMBREAK=0 equals abs9f: {same0}; (2) skeletons equal: {cfg}, feasible in the same "
          f"shapes: {feas}, feasible configurations {t0[2]} -> {t1[2]}, mismatches {t1[3]}")
for o0 in sorted(glob.glob(os.path.join(D, "abs9g", "o0_N*_L*.log")), key=key):
    nl = os.path.basename(o0)[3:]
    a, b = orbits(o0), orbits(os.path.join(D, "abs9g", "o1_" + nl))
    n0 = sum(1 for l in open(o0) if l.startswith("ORB "))
    n1 = sum(1 for l in open(os.path.join(D, "abs9g", "o1_" + nl)) if l.startswith("ORB "))
    good = a == b and len(a) > 0
    ok &= good
    print(f"{nl[:-4]:8s} (3) classes without / with the symmetry test: {len(a)} / {len(b)} "
          f"(feasible assignments {n0} / {n1}); same classes: {a == b}")
print("ALL CHECKS PASSED" if ok else "FAILURE")

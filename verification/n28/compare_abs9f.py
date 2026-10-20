#!/usr/bin/env python3
"""Compares the logs of abs9f in verification/n28/abs9f_vs_abs9/ with the logs of abs9 in logs/search/: for each
(N, L) the same shapes, and for each shape the same numbers of skeletons and feasible configurations; and the
same TOTAL numbers of skeletons, complete assignments, feasible configurations and mismatches."""
import glob
import os
import re

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))


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


def key(f):
    return [int(x) for x in re.findall(r"\d+", os.path.basename(f))]


ok, n = True, 0
for g in sorted(glob.glob(os.path.join(ROOT, "logs/search/abs9_N*_L*.log")), key=key):
    nl = os.path.basename(g)[len("abs9_"):]
    f = os.path.join(ROOT, "verification/n28/abs9f_vs_abs9", "abs9f_" + nl)
    b, tb = parse(g)
    a, ta = parse(f)
    same = ta is not None and set(a) == set(b) and all(a[s][:2] == b[s][:2] for s in a) and ta == tb
    ok &= same
    n += 1
    print(f"{nl[:-4]:8s} shapes {len(a):4d}  TOTAL abs9f {ta}  abs9 {tb}  same: {same}")
print(f"{n} runs; " + ("ALL EQUAL" if ok else "DIFFERENCES"))

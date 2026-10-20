#!/usr/bin/env python3
"""check_splits.py PROGRAM...  Runs each program (abs9f, abs9g) unsplit and split in the ways used at N = 28
(CFGSPLIT, CFGSPLIT2, DFSSPLIT, DFSSPLIT2, also all four nested, and for abs9g the five levels DFSSPLIT to
DFSSPLIT5 nested, and all seven splits nested) on several (N, L), and checks for every shape that
the shares add up to the unsplit run: the numbers of skeletons add up over the shares of the enumeration and are
repeated in every share of the depth-first search, and the numbers of feasible configurations and of complete
assignments (TOTAL leaves) add up over all shares."""
import concurrent.futures
import itertools
import os
import re
import subprocess
import sys

CASES = [(5, 6), (7, 7), (8, 7), (10, 8), (11, 8), (17, 9), (21, 10)]
LINE = re.compile(r"shape (\S+)((?: [a-z0-9]+=\S+)*) configs=(\d+) feasible=(\d+) nodes=(\d+)$")


def run(prog, n, l, env):
    e = dict(os.environ)
    for k in ("CFGSPLIT", "SPLITLEVEL", "CFGSPLIT2", "SPLITLEVEL2", "DFSSPLIT", "DFSSPLITDEPTH", "DFSSPLIT2",
              "DFSSPLITDEPTH2", "DFSSPLIT3", "DFSSPLITDEPTH3", "DFSSPLIT4", "DFSSPLITDEPTH4", "DFSSPLIT5",
              "DFSSPLITDEPTH5", "SYMBREAK", "SBORBIT", "SKIPFILE"):
        e.pop(k, None)
    e.update(env)
    out = subprocess.run([prog, str(n), str(l)], env=e, capture_output=True, text=True, check=True).stdout
    res = {}
    for line in out.splitlines():
        m = LINE.match(line)
        if m:
            res[m.group(1)] = (int(m.group(3)), int(m.group(4)))
        m = re.match(r"TOTAL configs=\d+ leaves=(\d+) ", line)
        if m:
            res["_leaves"] = (0, int(m.group(1)))
    return res


def main():
    ok = True
    for prog in sys.argv[1:]:
        name = os.path.basename(prog)
        for n, l in CASES:
            base = run(prog, n, l, {})
            # (a) CFGSPLIT=i/3 at level 4
            a = [run(prog, n, l, {"CFGSPLIT": f"{i}/3", "SPLITLEVEL": "4"}) for i in range(3)]
            ra = all(sum(p[s][0] for p in a) == base[s][0] and sum(p[s][1] for p in a) == base[s][1] for s in base)
            # (b) CFGSPLIT=i/2 at level 4 and CFGSPLIT2=j/3 at level 7
            b = [run(prog, n, l, {"CFGSPLIT": f"{i}/2", "SPLITLEVEL": "4", "CFGSPLIT2": f"{j}/3", "SPLITLEVEL2": "7"})
                 for i in range(2) for j in range(3)]
            rb = all(sum(p[s][0] for p in b) == base[s][0] and sum(p[s][1] for p in b) == base[s][1] for s in base)
            # (c) DFSSPLIT=m/3 at depth 2
            c = [run(prog, n, l, {"DFSSPLIT": f"{m}/3", "DFSSPLITDEPTH": "2"}) for m in range(3)]
            rc = all(all(p[s][0] == base[s][0] for p in c) and sum(p[s][1] for p in c) == base[s][1] for s in base)
            # (d) DFSSPLIT=m/3 at depth 2 and DFSSPLIT2=m2/4 at depth 4
            d = [run(prog, n, l, {"DFSSPLIT": f"{m}/3", "DFSSPLITDEPTH": "2", "DFSSPLIT2": f"{m2}/4",
                                  "DFSSPLITDEPTH2": "4"}) for m in range(3) for m2 in range(4)]
            rd = all(all(p[s][0] == base[s][0] for p in d) and sum(p[s][1] for p in d) == base[s][1] for s in base)
            # (e) all four nested, two shares each
            keys = list(itertools.product(range(2), repeat=4))
            e = {k: run(prog, n, l, {"CFGSPLIT": f"{k[0]}/2", "SPLITLEVEL": "4", "CFGSPLIT2": f"{k[1]}/2",
                                     "SPLITLEVEL2": "7", "DFSSPLIT": f"{k[2]}/2", "DFSSPLITDEPTH": "2",
                                     "DFSSPLIT2": f"{k[3]}/2", "DFSSPLITDEPTH2": "4"}) for k in keys}
            re_ = all(sum(e[(i, j, m, m2)][s][0] for i in range(2) for j in range(2)) == base[s][0]
                      for m in range(2) for m2 in range(2) for s in base) and \
                all(sum(e[k][s][1] for k in keys) == base[s][1] for s in base)
            # (f) abs9g only: the five levels of the depth-first search nested, two shares each (N >= 7, so that
            # every configuration has more sources than the deepest split depth)
            rf = True
            if name.startswith("abs9g") and n >= 7:
                keys5 = list(itertools.product(range(2), repeat=5))
                f5 = {k: run(prog, n, l, {"DFSSPLIT": f"{k[0]}/2", "DFSSPLITDEPTH": "1", "DFSSPLIT2": f"{k[1]}/2",
                                          "DFSSPLITDEPTH2": "2", "DFSSPLIT3": f"{k[2]}/2", "DFSSPLITDEPTH3": "3",
                                          "DFSSPLIT4": f"{k[3]}/2", "DFSSPLITDEPTH4": "4", "DFSSPLIT5": f"{k[4]}/2",
                                          "DFSSPLITDEPTH5": "5"}) for k in keys5}
                rf = all(all(f5[k][s][0] == base[s][0] for k in keys5) and sum(f5[k][s][1] for k in keys5) == base[s][1]
                         for s in base)
            # (g) abs9g only, 7 <= N <= 11: all seven splits nested, two shares each (128 runs)
            rg = True
            if name.startswith("abs9g") and 7 <= n <= 11:
                keys7 = list(itertools.product(range(2), repeat=7))
                envs = {k: {"CFGSPLIT": f"{k[0]}/2", "SPLITLEVEL": "4", "CFGSPLIT2": f"{k[1]}/2", "SPLITLEVEL2": "7",
                            "DFSSPLIT": f"{k[2]}/2", "DFSSPLITDEPTH": "1", "DFSSPLIT2": f"{k[3]}/2",
                            "DFSSPLITDEPTH2": "2", "DFSSPLIT3": f"{k[4]}/2", "DFSSPLITDEPTH3": "3",
                            "DFSSPLIT4": f"{k[5]}/2", "DFSSPLITDEPTH4": "4", "DFSSPLIT5": f"{k[6]}/2",
                            "DFSSPLITDEPTH5": "5"} for k in keys7}
                with concurrent.futures.ThreadPoolExecutor(max_workers=32) as ex:
                    futs = {k: ex.submit(run, prog, n, l, envs[k]) for k in keys7}
                    g7 = {k: f.result() for k, f in futs.items()}
                rg = all(sum(g7[(i, j) + d][s][0] for i in range(2) for j in range(2)) == base[s][0]
                         for d in itertools.product(range(2), repeat=5) for s in base) and \
                    all(sum(g7[k][s][1] for k in keys7) == base[s][1] for s in base)
            feas = sum(v[1] for k, v in base.items() if k != "_leaves")
            good = ra and rb and rc and rd and re_ and rf and rg and len(base) > 0
            ok &= good
            print(f"{name} N={n} L={l}: shapes {len(base) - 1}, skeletons {sum(v[0] for v in base.values())}, "
                  f"feasible {feas}, complete assignments {base['_leaves'][1]}; CFGSPLIT {ra}, +CFGSPLIT2 {rb}, "
                  f"DFSSPLIT {rc}, +DFSSPLIT2 {rd}, all four {re_}"
                  + (f", five DFS levels {rf}" if name.startswith("abs9g") and n >= 7 else "")
                  + (f", all seven {rg}" if name.startswith("abs9g") and 7 <= n <= 11 else ""))
    print("ALL SPLIT CHECKS PASSED" if ok else "SPLIT CHECK FAILURE")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())

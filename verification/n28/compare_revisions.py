#!/usr/bin/env python3
"""compare_revisions.py BUILD_DIR  Compares the five revisions of abs9g that wrote the logs of logs/n28/sym17/:
revision 1 (src/earlier/abs9g_r1.cpp: logs y_* and z_*), revision 2 (src/earlier/abs9g_r2.cpp: logs w_* and v_*),
revision 3 (src/earlier/abs9g_r3.cpp: logs t_*), revision 4 (src/earlier/abs9g_r4.cpp: logs q_*) and revision 5
(src/abs9g.cpp: logs p_*). Revision 2 evaluates the test (P3) by one inequality per ancestor and resumes the
comparisons of the symmetry test along each path; revisions 3 to 5 add DFSSPLIT3 to DFSSPLIT5. Without these options
all five should print exactly the same lines. The script builds them in BUILD_DIR and compares the standard output of
revisions 1 to 4 with that of revision 5, byte for byte, on the 22 runs of logs/search/ (with and without the
symmetry test) and at the 9 levels with feasible configurations with SBORBIT=1. It then reruns revision 5 on 42
shares of logs/n28/sym17/, six from the logs of each of the seven scripts (spread over the shares with at most 40
million nodes, or the six smallest), with their split options, and compares the result line with the logged
one."""
import concurrent.futures
import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
B = sys.argv[1]
os.makedirs(B, exist_ok=True)
R1, R2, R3r, R4r, R3 = (os.path.join(B, x) for x in ("abs9g_r1", "abs9g_r2", "abs9g_r3", "abs9g_r4", "abs9g"))
for exe, src in ((R1, "src/earlier/abs9g_r1.cpp"), (R2, "src/earlier/abs9g_r2.cpp"), (R3r, "src/earlier/abs9g_r3.cpp"),
                 (R4r, "src/earlier/abs9g_r4.cpp"), (R3, "src/abs9g.cpp")):
    subprocess.run(["g++", "-O2", "-std=c++17", "-o", exe, os.path.join(ROOT, src)], check=True)
CLEAN = ("CFGSPLIT", "SPLITLEVEL", "CFGSPLIT2", "SPLITLEVEL2", "DFSSPLIT", "DFSSPLITDEPTH", "DFSSPLIT2",
         "DFSSPLITDEPTH2", "DFSSPLIT3", "DFSSPLITDEPTH3", "DFSSPLIT4", "DFSSPLITDEPTH4", "DFSSPLIT5",
         "DFSSPLITDEPTH5", "SYMBREAK", "SBORBIT", "SKIPFILE")


def run(prog, args, env):
    e = {k: v for k, v in os.environ.items() if k not in CLEAN}
    e.update(env)
    return subprocess.run([prog] + [str(a) for a in args], env=e, capture_output=True, text=True, check=True).stdout


ok = True
cases = []
for fn in sorted(os.listdir(os.path.join(ROOT, "logs/search"))):
    m = re.match(r"abs9_N(\d+)_L(\d+)\.log$", fn)
    if m:
        cases.append((int(m.group(1)), int(m.group(2))))
cases.sort()
jobs = [((N, L), {"SYMBREAK": sb}) for N, L in cases for sb in ("0", "1")]
jobs += [((N, L), {"SBORBIT": "1"}) for N, L in [(3, 3), (4, 4), (5, 6), (6, 6), (7, 7), (8, 7), (9, 8), (10, 8), (11, 8)]]
REVS = (R1, R2, R3r, R4r, R3)
with concurrent.futures.ThreadPoolExecutor(max_workers=32) as ex:
    futs = {(i, r): ex.submit(run, r, list(job[0]), job[1]) for i, job in enumerate(jobs) for r in REVS}
    n = 0
    for i, job in enumerate(jobs):
        o3 = futs[(i, R3)].result()
        same = all(futs[(i, r)].result() == o3 for r in REVS[:-1])
        ok &= same
        n += 1
        if not same:
            print(f"DIFFERENT: N={job[0][0]} L={job[0][1]} {job[1]}")
print(f"small runs: {n} runs, outputs of revisions 1 to 4 compared byte for byte with revision 5, all equal: {ok}")

# shares at N = 28 written by revision 1
LINE = re.compile(r"shape (\S+)((?: [a-z0-9]+=\S+)*) configs=(\d+) feasible=(\d+) nodes=(\d+)$")
shares = []
d = os.path.join(ROOT, "logs/n28/sym17")
for fn in sorted(os.listdir(d)):
    idx = int(re.match(r"y_(\d+)\.txt$", fn).group(1))
    name = None
    for raw in open(os.path.join(d, fn)):
        line = raw.rstrip("\n")
        m = re.match(r"==> (\S+) <==$", line)
        if m:
            name = m.group(1)
            continue
        m = LINE.match(line)
        if m and name and int(m.group(5)) >= 2_000_000:
            shares.append((idx, name, line, dict(t.split("=") for t in m.group(2).split()), int(m.group(5))))
# six shares from the logs of each script (y_, z_: revision 1; w_, v_: revision 2; t_: 3; q_: 4; p_: 5), spread
# over those with at most 40 million nodes, or the six smallest if there are fewer such shares
picked = []
for prefix in "yzwvtqp":
    group = [x for x in shares if x[1][0] == prefix]
    small = [x for x in group if x[4] <= 40_000_000]
    picked += small[::max(1, len(small) // 6)][:6] if len(small) >= 6 else sorted(group, key=lambda x: x[4])[:6]
shares = [x[:4] for x in picked]
good = 0


def envof(lab):
    env = {"CFGSPLIT": lab["part"], "SPLITLEVEL": "10"}
    if "sub" in lab:
        env.update({"CFGSPLIT2": lab["sub"], "SPLITLEVEL2": "16"})
    if "dsplit" in lab:
        env.update({"DFSSPLIT": lab["dsplit"], "DFSSPLITDEPTH": lab["depth"]})
    if "dsplit2" in lab:
        env.update({"DFSSPLIT2": lab["dsplit2"], "DFSSPLITDEPTH2": lab["depth2"]})
    for lev in ("3", "4", "5"):
        if "dsplit" + lev in lab:
            env.update({"DFSSPLIT" + lev: lab["dsplit" + lev], "DFSSPLITDEPTH" + lev: lab["depth" + lev]})
    return env


with concurrent.futures.ThreadPoolExecutor(max_workers=24) as ex:
    futs = [ex.submit(run, R3, [28, 11, idx, 62641], envof(lab)) for idx, name, line, lab in shares]
    for (idx, name, line, lab), fu in zip(shares, futs):
        out = [l for l in fu.result().splitlines() if l.startswith("shape")]
        same = out == [line]
        good += same
        ok &= same
        print(f"{name}: {'same' if same else 'DIFFERENT'} ({line.split(' nodes=')[1]} nodes)")
print(f"N=28 shares: {good} of {len(shares)} result lines equal")
print("REVISIONS AGREE" if ok and shares else "REVISION CHECK FAILED")

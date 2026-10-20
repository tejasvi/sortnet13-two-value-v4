#!/usr/bin/env python3
"""Checks the logs of the search at N = 28, L = 11 and prints the numbers quoted in the paper.

logs/n28/ holds the run used in the paper:
  shards/      abs9f on all shapes except the 119 of logs/n28/skip119.txt, in 4096 processes; process s
               takes the shapes whose index is s modulo 4096 (logs pb_<s>.log)
  split102/    abs9f on 102 of the 119 shapes, each split into 64 shares (CFGSPLIT=i/64 at level 10)
  sym17/       abs9g on the other 17 shapes: the same 64 shares; some shares split again into 64
               (CFGSPLIT2 at level 16), some of these into shares of the depth-first search (DFSSPLIT),
               and some of those again (DFSSPLIT2 to DFSSPLIT5)
logs/n28_earlier/ holds an earlier run (abs5, abs9, abs9m, abs9c), used only as a cross-check.

Each file is the concatenation of the original log files, each preceded by a line "==> <name> <==".
The script checks that every log is complete (last line "EXIT 0"), that no shape line and no TOTAL line reports a
feasible configuration or a simulation mismatch, that the abs9g logs ran with the symmetry test, that the
shares of every split are complete and cover each of the 62,641 shapes, and that the earlier run agrees. The
list of shapes is recomputed here exactly as the programs compute it.
"""
import collections
import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
N, L, H = 28, 11, 6
NSHARDS = 4096
HEADER = f"N={N} L={L} H={H} shapes=62641"
LINE = re.compile(r"shape (\S+)((?: [a-z0-9]+=\S+)*) configs=(\d+) feasible=(\d+) nodes=(\d+)$")
TOTAL = re.compile(r"TOTAL configs=(\d+) leaves=(\d+) feasible=(\d+) simfail=(\d+)$")
FAIL = []


def fail(msg):
    FAIL.append(msg)
    if len(FAIL) <= 20:
        print("FAIL:", msg)


def shapes(n, h, memo={}):
    """The tree shapes with n leaves and height at most h, in the order of shapes() in src/abs9f.cpp."""
    key = (n, h)
    if key in memo:
        return memo[key]
    res = []
    if n == 1:
        res = ["L"]
    elif h > 0:
        seen = set()
        for a in range(1, n // 2 + 1):
            A, Bv = shapes(a, h - 1), shapes(n - a, h - 1)
            for s in A:
                for t in Bv:
                    u = "(" + s + t + ")" if s < t else "(" + t + s + ")"
                    if u not in seen:
                        seen.add(u)
                        res.append(u)
    memo[key] = res
    return res


def read_concat(path):
    """Yield (name, lines) for each log in a concatenated file."""
    name, lines = None, []
    with open(path) as f:
        for raw in f:
            line = raw.rstrip("\n")
            m = re.match(r"==> (\S+) <==$", line)
            if m:
                if name is not None:
                    yield name, lines
                name, lines = m.group(1), []
            else:
                lines.append(line)
    if name is not None:
        yield name, lines


def parse_log(name, lines, sym):
    """Check one complete log; return its shape lines as (shape, labels, configs, feasible, nodes) and TOTAL."""
    body = [l for l in lines if l != ""]
    if not body or body[0] != HEADER:
        fail(f"{name}: header")
    if not body or body[-1] != "EXIT 0":
        fail(f"{name}: not complete")
    if sym and (len(body) < 2 or body[1] != "SYMBREAK 1"):
        fail(f"{name}: abs9g log without SYMBREAK 1")
    if not sym and any(l.startswith("SYMBREAK") for l in body):
        fail(f"{name}: unexpected SYMBREAK line")
    out, tot = [], None
    for l in body:
        m = LINE.match(l)
        if m:
            labels = dict(t.split("=") for t in m.group(2).split())
            out.append((m.group(1), labels, int(m.group(3)), int(m.group(4)), int(m.group(5))))
            if int(m.group(4)) != 0:
                fail(f"{name}: feasible configuration reported")
        m = TOTAL.match(l)
        if m:
            tot = tuple(int(x) for x in m.groups())
    if tot is None:
        fail(f"{name}: no TOTAL line")
        tot = (0, 0, 0, 0)
    if tot[2] != 0 or tot[3] != 0:
        fail(f"{name}: TOTAL reports feasible or simfail")
    if sum(x[2] for x in out) != tot[0]:
        fail(f"{name}: configs of the shape lines do not add up to TOTAL")
    return out, tot


def frac(s):
    a, b = s.split("/")
    return int(a), int(b)


def main():
    S = shapes(N, H)
    if len(S) != 62641:
        fail(f"{len(S)} shapes instead of 62641")
    index = {s: i for i, s in enumerate(S)}
    d = os.path.join(ROOT, "logs", "n28")
    skip = [l.strip() for l in open(os.path.join(d, "skip119.txt")) if l.strip()]
    skipset = set(skip)
    if len(skip) != 119 or len(skipset) != 119 or not skipset <= set(index):
        fail("skip119.txt is not a set of 119 shapes")
    covered = collections.Counter()   # shape -> number of methods that cover it
    tot_cfg = tot_nodes = tot_leaves = 0
    nlogs = collections.Counter()
    dup = collections.Counter()

    # 1. shards
    seen = set()
    for fn in sorted(os.listdir(os.path.join(d, "shards"))):
        for name, lines in read_concat(os.path.join(d, "shards", fn)):
            m = re.match(r"pb_(\d+)\.log$", name)
            s = int(m.group(1))
            if s in seen:
                fail(f"shard {s} twice")
            seen.add(s)
            out, tot = parse_log(name, lines, sym=False)
            want = [S[i] for i in range(s, len(S), NSHARDS) if S[i] not in skipset]
            if [x[0] for x in out] != want or any(x[1] for x in out):
                fail(f"{name}: shape lines differ from the shapes of shard {s}")
            for x in out:
                covered[x[0]] += 1
            tot_cfg += tot[0]
            tot_nodes += sum(x[4] for x in out)
            tot_leaves += tot[1]
            nlogs["shards"] += 1
    if seen != set(range(NSHARDS)):
        fail(f"{NSHARDS - len(seen)} shards missing")
    shard_cfg = {}
    for fn in sorted(os.listdir(os.path.join(d, "shards"))):
        for name, lines in read_concat(os.path.join(d, "shards", fn)):
            for l in lines:
                m = LINE.match(l)
                if m:
                    shard_cfg[m.group(1)] = int(m.group(3))

    # 2. the 102 shapes split into 64 shares by abs9f
    split102 = set()
    for fn in sorted(os.listdir(os.path.join(d, "split102"))):
        m = re.match(r"f_(\d+)\.txt$", fn)
        idx = int(m.group(1))
        shape = S[idx]
        parts = {}
        for name, lines in read_concat(os.path.join(d, "split102", fn)):
            mm = re.match(rf"f_{idx}_(\d+)\.log$", name)
            if not mm:
                fail(f"{fn}: unexpected log {name}")
                continue
            out, tot = parse_log(name, lines, sym=False)
            if len(out) != 1 or out[0][0] != shape or set(out[0][1]) != {"part"} or \
                    frac(out[0][1]["part"]) != (int(mm.group(1)), 64):
                fail(f"{name}: shape line")
                continue
            i = int(mm.group(1))
            if i in parts:
                fail(f"{name}: share twice")
            parts[i] = (out[0], tot)
            nlogs["split102"] += 1
        if set(parts) != set(range(64)):
            fail(f"{fn}: shares missing")
        for i, (x, tot) in parts.items():
            tot_cfg += x[2]
            tot_nodes += x[4]
            tot_leaves += tot[1]
        covered[shape] += 1
        split102.add(shape)

    # 3. the 17 shapes searched by abs9g
    sym17 = set()
    struct = collections.Counter()
    for fn in sorted(os.listdir(os.path.join(d, "sym17"))):
        m = re.match(r"y_(\d+)\.txt$", fn)
        idx = int(m.group(1))
        shape = S[idx]
        recs = []
        for name, lines in read_concat(os.path.join(d, "sym17", fn)):
            if not re.match(rf"[yzwvtqp]_{idx}_\d+_\d+_\d+of\d+d\d+(_\d+of\d+d\d+){{0,4}}\.log$", name):
                fail(f"{fn}: unexpected log {name}")
                continue
            out, tot = parse_log(name, lines, sym=True)
            if len(out) != 1 or out[0][0] != shape:
                fail(f"{name}: shape line")
                continue
            recs.append((name, out[0], tot))
            nlogs["sym17"] += 1
        # units: part i [/ sub j [/ dsplit m of R at D [/ dsplit2 m2 of R2 at D2]]]
        own = {}
        for name, x, tot in recs:
            lab = x[1]
            if not set(lab) <= {"part", "sub", "dsplit", "depth", "dsplit2", "depth2", "dsplit3", "depth3", "dsplit4",
                                "depth4", "dsplit5", "depth5"}:
                fail(f"{name}: labels")
            i, P = frac(lab["part"])
            key = [("part", i, P)]
            if "sub" in lab:
                j, Q = frac(lab["sub"])
                key.append(("sub", j, Q))
            if "dsplit" in lab:
                mm, R = frac(lab["dsplit"])
                key.append(("dsplit", mm, R, int(lab["depth"])))
            if "dsplit2" in lab:
                m2, R2 = frac(lab["dsplit2"])
                key.append(("dsplit2", m2, R2, int(lab["depth2"])))
            if "dsplit3" in lab:
                m3, R3 = frac(lab["dsplit3"])
                key.append(("dsplit3", m3, R3, int(lab["depth3"])))
            if "dsplit4" in lab:
                m4, R4 = frac(lab["dsplit4"])
                key.append(("dsplit4", m4, R4, int(lab["depth4"])))
            if "dsplit5" in lab:
                m5, R5 = frac(lab["dsplit5"])
                key.append(("dsplit5", m5, R5, int(lab["depth5"])))
            key = tuple(key)
            if key in own:
                # the same share run twice (by revisions 1 and 2 of abs9g): the result lines must agree exactly
                if own[key][0][1:] != x[1:]:
                    fail(f"{name}: share run twice with different results")
                dup["sym17"] += 1
                continue
            own[key] = (x, tot)

        def complete(prefix):
            """Return (configs, nodes, leaves, structure) for the unit with this key prefix, or None."""
            if prefix in own:
                x, tot = own[prefix]
                return x[2], x[4], tot[1], collections.Counter({len(prefix): 1})
            # the unit is split: find the children kinds present
            kids = [k for k in own if len(k) > len(prefix) and k[:len(prefix)] == prefix]
            if not kids:
                return None
            kinds = set(k[len(prefix)][0] for k in kids)
            if len(kinds) != 1:
                fail(f"y_{idx}: unit {prefix} split in two ways")
                return None
            kind = kinds.pop()
            nexts = set(k[len(prefix)] for k in kids)
            if kind == "sub":
                Qs = set(t[2] for t in nexts)
                if len(Qs) != 1:
                    fail(f"y_{idx}: {prefix} split with several Q")
                    return None
                Q = Qs.pop()
                res = [complete(prefix + (("sub", j, Q),)) for j in range(Q)]
                if any(r is None for r in res):
                    return None
                st = sum((r[3] for r in res), collections.Counter())
                st["split sub"] += 1
                return sum(r[0] for r in res), sum(r[1] for r in res), sum(r[2] for r in res), st
            # DFS splits: every share repeats all skeletons of the unit. A unit may have been split in more than
            # one way (different R or depth); use the first way, by increasing R, whose shares are all complete.
            for R, D in sorted(set((t[2], t[3]) for t in nexts)):
                res = [complete(prefix + ((kind, mm, R, D),)) for mm in range(R)]
                if any(r is None for r in res):
                    continue
                if len(set(r[0] for r in res)) != 1:
                    fail(f"y_{idx}: {prefix} DFS shares with different skeleton counts")
                st = sum((r[3] for r in res), collections.Counter())
                st[f"split {kind} {R}@{D}"] += 1
                return res[0][0], sum(r[1] for r in res), sum(r[2] for r in res), st
            return None

        ok = True
        for i in range(64):
            r = complete((("part", i, 64),))
            if r is None:
                fail(f"y_{idx}: part {i} not covered")
                ok = False
                continue
            tot_cfg += r[0]
            tot_nodes += r[1]
            tot_leaves += r[2]
            struct += r[3]
        if ok:
            covered[shape] += 1
            sym17.add(shape)

    # 4. coverage
    if split102 | sym17 != skipset or len(split102) != 102 or len(sym17) != 17:
        fail("the split runs do not cover exactly the 119 skipped shapes")
    missing = [s for s in S if covered[s] == 0]
    twice = [s for s in S if covered[s] > 1]
    if missing or twice:
        fail(f"{len(missing)} shapes not covered, {len(twice)} covered twice")
    print(f"shapes: {len(S)}; covered {sum(1 for s in S if covered[s] == 1)}; by the shards "
          f"{len(S) - len(skipset)}, by abs9f in 64 shares {len(split102)}, by abs9g {len(sym17)}")
    print(f"logs: shards {nlogs['shards']}, split102 {nlogs['split102']}, sym17 {nlogs['sym17']} "
          f"(of which {dup['sym17']} repeat a share with the same result line)")
    names = {1: "parts", 2: "sub-parts", 3: "DFS shares", 4: "level-2 DFS shares", 5: "level-3 DFS shares",
             6: "level-4 DFS shares", 7: "level-5 DFS shares"}
    print("abs9g, logs used, by kind of share:", ", ".join(f"{names[k]} {v}" for k, v in sorted(struct.items(), key=str)
                                                         if isinstance(k, int)))
    print("abs9g, units split, by kind of split:", ", ".join(f"{k[6:]} {v}" for k, v in sorted(struct.items(), key=str)
                                                            if isinstance(k, str)))
    print(f"totals: skeletons {tot_cfg:,}; search nodes {tot_nodes:,}; complete assignments {tot_leaves:,}")

    # 5. the earlier run
    e = os.path.join(ROOT, "logs", "n28_earlier")
    earlier = collections.defaultdict(list)
    for fn in sorted(os.listdir(e)):
        if not fn.endswith(".txt"):
            continue
        for name, lines in read_concat(os.path.join(e, fn)):
            for l in lines:
                m = LINE.match(l)
                if m:
                    earlier[m.group(1)].append((fn, int(m.group(3)), int(m.group(4))))
    if any(f != 0 for v in earlier.values() for (_, _, f) in v):
        fail("the earlier run reports a feasible configuration")
    eset = set(earlier)
    if eset != set(S) - skipset:
        fail(f"earlier run: {len(eset)} shapes, expected the {len(S) - len(skipset)} shapes outside skip119")
    agree = disagree = 0
    for s, v in earlier.items():
        for fn, c, _ in v:
            if fn.startswith("part1_abs5"):
                continue   # abs5 does not apply (P1), so its counts are not comparable
            if shard_cfg.get(s) == c:
                agree += 1
            else:
                disagree += 1
    if disagree:
        fail(f"earlier run: {disagree} shape lines with another number of skeletons")
    print(f"earlier run: {len(eset)} shapes, no feasible configuration; skeleton counts agree with the shards on "
          f"{agree} shape lines of abs9, abs9m and abs9c, disagree on {disagree}")
    print("ALL N=28 CHECKS PASSED" if not FAIL else f"{len(FAIL)} FAILURES")
    return 0 if not FAIL else 1


if __name__ == "__main__":
    sys.exit(main())

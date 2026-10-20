#!/usr/bin/env python3
"""Generate data files and Lean modules for the kernel certificate check.
usage: mkmods.py KEYS CERTS TARGET_MS [maxchunks]
Chunks are cut greedily so that the estimated kernel time sum_i (14 iso_i + 2.6 (78 - iso_i)) ms of a
chunk stays below TARGET_MS (iso_i = number of certificate entries of state i).
Writes data/keys.txt, data/c/cNNNNN.txt, S13Kernel/Data/Keys.lean, S13Kernel/Chunks/CNNNNN.lean,
S13Kernel/Agg/*.lean (fan-in FAN), S13Kernel/All.lean. Files are rewritten only if their content changes."""
import sys, os, hashlib
ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CHANGED = [0]
FAN = 64

def write_if_changed(path, content):
    path = os.path.join(ROOT, path)
    os.makedirs(os.path.dirname(path), exist_ok=True)
    if os.path.exists(path) and open(path).read() == content:
        return False
    open(path, 'w').write(content)
    CHANGED[0] += 1
    return True

def sha(s): return hashlib.sha256(s.encode()).hexdigest()

def main():
    keys_path, certs_path, target = sys.argv[1], sys.argv[2], float(sys.argv[3])
    maxchunks = int(sys.argv[4]) if len(sys.argv) > 4 else None
    keys = open(keys_path).read()
    klines = keys.split('\n')
    if klines[-1] == '': klines = klines[:-1]
    N = len(klines)
    clines = open(certs_path).read().split('\n')
    if clines[-1] == '': clines = clines[:-1]
    assert len(clines) == N, (len(clines), N)
    write_if_changed('data/keys.txt', keys)
    write_if_changed('S13Kernel/Data/Keys.lean', f'''import S13Kernel.Load

/-! The keys of the certificate (untrusted data). `data/keys.txt` has sha256 {sha(keys)}. -/

namespace S13K.Data

load_keys S from "data/keys.txt"

/-- The number of keys. -/
def N : Nat := {N}

end S13K.Data
''')
    bounds = []
    lo, acc = 0, 0.0
    for i, l in enumerate(clines):
        iso = len(l.split())
        w = 14.0 * iso + 2.6 * (78 - iso)
        if i > lo and acc + w > target:
            bounds.append((lo, i)); lo, acc = i, 0.0
        acc += w
    bounds.append((lo, N))
    nchunks = len(bounds)
    if maxchunks: nchunks = min(nchunks, maxchunks)
    ranges = []
    for c in range(nchunks):
        lo, hi = bounds[c]
        data = '\n'.join(clines[lo:hi]) + '\n'
        write_if_changed(f'data/c/c{c:05d}.txt', data)
        write_if_changed(f'S13Kernel/Chunks/C{c:05d}.lean', f'''import S13Kernel.Data.Keys

/-! Keys number {lo} to {hi - 1}. `data/c/c{c:05d}.txt` has sha256 {sha(data)}. -/

namespace S13K.Chunks.C{c:05d}

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c{c:05d}.txt"

theorem chk : chkChunk S N {lo} {hi - lo} ces = true := by decide +kernel

theorem ok : RangeOK S N {lo} {hi} := rangeOK_of_chkChunk chk

end S13K.Chunks.C{c:05d}
''')
        ranges.append((f'S13K.Chunks.C{c:05d}', f'S13Kernel.Chunks.C{c:05d}', lo, hi))
    # aggregation tree
    level = 0
    while len(ranges) > 1:
        level += 1
        nxt = []
        for g in range(0, len(ranges), FAN):
            grp = ranges[g:g + FAN]
            lo, hi = grp[0][2], grp[-1][3]
            name = f'S13K.Agg.L{level}_{g // FAN:04d}'
            mod = f'S13Kernel.Agg.L{level}_{g // FAN:04d}'
            imports = '\n'.join(f'import {m[1]}' for m in grp)
            proof = f'{grp[0][0]}.ok'
            for m in grp[1:]:
                proof = f'({proof}).append {m[0]}.ok'
            write_if_changed(f'S13Kernel/Agg/L{level}_{g // FAN:04d}.lean', f'''{imports}

namespace {name}

open S13K S13K.Data

theorem ok : RangeOK S N {lo} {hi} :=
  {proof}

end {name}
''')
            nxt.append((name, mod, lo, hi))
        ranges = nxt
    top = ranges[0]
    write_if_changed('S13Kernel/All.lean', f'''import {top[1]}

namespace S13K

open S13K.Data

/-- Every key passes the closure check. -/
theorem all_ok : RangeOK S N {top[2]} {top[3]} := {top[0]}.ok

end S13K
''')
    open(os.path.join(ROOT, 'data/chunks.tsv'), 'w').write(''.join(f'{c}\t{bounds[c][0]}\t{bounds[c][1]}\n' for c in range(nchunks)))
    print(f'N={N} target={target} chunks={nchunks} levels={level} top=[{top[2]},{top[3]}) files_changed={CHANGED[0]}')

main()

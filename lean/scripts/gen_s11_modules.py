#!/usr/bin/env python3
"""Write S11Data/ChunkNN.lean and S11Data/Cert.lean from data/s11/manifest.txt (written by
tools/split.cpp: one line "name size fnv1a64" per chunk file)."""
import os
root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
man = [l.split() for l in open(os.path.join(root, 'data', 's11', 'manifest.txt')) if l.strip()]
os.makedirs(os.path.join(root, 'S11Data'), exist_ok=True)
for k, (name, size, h) in enumerate(man):
    open(os.path.join(root, 'S11Data', f'Chunk{k:02d}.lean'), 'w').write(
        f'import S11Loader\n\n/-! Chunk {k} of the certificate ({size} characters). -/\n\n'
        f'load_cert_chunk Sortnet.S11Data.chunk{k:02d} "data/s11/{name}" {h}\n')
imports = ''.join(f'import S11Data.Chunk{k:02d}\n' for k in range(len(man)))
names = ', '.join(f'chunk{k:02d}' for k in range(len(man)))
open(os.path.join(root, 'S11Data', 'Cert.lean'), 'w').write(f'''import S11Comp
{imports}
/-!
# The certificate for `S(11) ≥ 35`

Harder's certificate, converted to the format of `S11Comp` (`scripts/s11_data.sh`), split into
{len(man)} chunks of at most 64 MiB, which are loaded at build time (`S11Data.Loader`).
-/

namespace Sortnet.S11Data

open Sortnet.S11

/-- Characters per chunk. -/
def chunkSize : Nat := 67108864

/-- The chunks of the certificate. -/
def chunks : Array String := #[{names}]

/-- Character `i` of the certificate (`0` beyond its end). -/
def certByte (i : Nat) : Nat :=
  match chunks[i / chunkSize]? with
  | some s =>
    let off := i % chunkSize
    if h : (⟨off⟩ : String.Pos.Raw) < s.rawEndPos then (s.getUTF8Byte ⟨off⟩ h).toNat else 0
  | none => 0

/-- The number of steps. -/
def certCount : Nat := readNum certByte 0 4

/-- The step offsets. -/
def certOffsets : Array Nat := offsets certByte certCount

/-- The certificate. -/
def theCert : Cert := ⟨certByte, fun s => certOffsets.getD s 0⟩

end Sortnet.S11Data
''')
print(len(man), 'chunk modules written')

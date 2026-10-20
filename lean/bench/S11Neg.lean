import S11Comp
open Sortnet.S11

/-! Negative controls: corrupt the certificate in memory and check that the affected step fails. -/

def offsetsOf (byte : Nat → Nat) (count : Nat) : Array Nat := offsets byte count

def main (args : List String) : IO Unit := do
  let data ← IO.FS.readBinFile args[0]!
  let byte0 : Nat → Nat := fun i => (data.get! i).toNat
  let count := readNum byte0 0 4
  let offs := offsetsOf byte0 count
  let c0 : Cert := ⟨byte0, fun s => offs.getD s 0⟩
  let check (name : String) (patches : List (Nat × Nat)) (s : Nat) : IO Unit := do
    let byte : Nat → Nat := fun i => match patches.find? (·.1 == i) with
      | some (_, v) => v
      | none => byte0 i
    let c : Cert := ⟨byte, fun s => offs.getD s 0⟩
    IO.println s!"{name}: step {s} kind={c0.kind s} W={c0.W s} Bd={c0.Bd s}: original {c0.checkStep s}, corrupted {c.checkStep s}"
  let last := count - 1
  -- (a) last step claims 36 instead of 35
  check "bound 35->36 (last)" [(offs[last]! + 1, 36)] last
  -- pick some successor and Huffman steps
  let mut succs : Array Nat := #[]
  let mut huffs : Array Nat := #[]
  for s in [6000000:6000400] do
    if c0.kind s == 2 && c0.nw s > 0 then succs := succs.push s
    if c0.kind s ≤ 1 && c0.nw s > 0 then huffs := huffs.push s
  for s in succs.toList.take 5 do
    -- (b) perturb the permutation of witness 0
    let p := c0.witOff s 0 + 4
    check "perm of witness 0 perturbed" [(p, (byte0 p + 1) % 128)] s
    -- (c) witness 0 points to the step itself
    let q := c0.witOff s 0
    let v := readNum byte0 q 4
    let v' := v % 4 + 4 * s
    check "witness 0 id := s" [(q, v' % 128), (q+1, v' / 128 % 128), (q+2, v' / 16384 % 128), (q+3, v' / 2097152 % 128)] s
    -- (d) witness 0 replaced by "no witness"
    check "witness 0 := none" [(q, 2), (q+1, 0), (q+2, 0), (q+3, 0)] s
    -- (e) bound + 1
    check "bound + 1" [(offs[s]! + 1, c0.Bd s + 1)] s
  for s in huffs.toList.take 5 do
    check "huffman bound + 1" [(offs[s]! + 1, c0.Bd s + 1)] s
    let p := c0.witOff s 0 + 4
    check "huffman perm of witness 0 perturbed" [(p, (byte0 p + 1) % 128)] s
  -- (f) invalid kind
  check "kind := 3" [(offs[last]! + 2, 3)] last

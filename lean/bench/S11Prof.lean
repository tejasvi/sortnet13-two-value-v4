import S11Comp
open Sortnet.S11

def offsets (byte : Nat → Nat) (count : Nat) : Array Nat := Id.run do
  let mut a : Array Nat := Array.mkEmpty count
  let mut o := 4
  for _ in [0:count] do
    a := a.push o
    let w := byte o
    o := o + 4 + bmLen w + 8 * byte (o + 3)
  return a

def main (args : List String) : IO Unit := do
  let data ← IO.FS.readBinFile args[0]!
  let a := args[1]!.toNat!
  let b := args[2]!.toNat!
  let byte : Nat → Nat := fun i => (data.get! i).toNat
  let count := readNum byte 0 4
  let offs := offsets byte count
  let c : Cert := ⟨byte, fun s => offs.getD s 0⟩
  -- time per (kind, width)
  let mut tot : Array Nat := Array.replicate 64 0
  let mut cnt : Array Nat := Array.replicate 64 0
  let mut wits : Array Nat := Array.replicate 64 0
  let mut elemT : Nat := 0
  for s in [a:b] do
    let key := c.kind s * 16 + c.W s
    let t0 ← IO.monoNanosNow
    let ok := c.checkStep s
    let t1 ← IO.monoNanosNow
    if !ok then IO.println s!"FAIL {s}"
    tot := tot.modify key (· + (t1 - t0))
    cnt := cnt.modify key (· + 1)
    wits := wits.modify key (· + c.nw s)
    let t2 ← IO.monoNanosNow
    let e := c.elems s
    let t3 ← IO.monoNanosNow
    if e.length == 12345678 then IO.println "x"
    elemT := elemT + (t3 - t2)
  for key in [0:64] do
    if cnt[key]! > 0 then
      IO.println s!"kind={key / 16} w={key % 16} steps={cnt[key]!} avg_us={tot[key]! / cnt[key]! / 1000} avg_wits={wits[key]! / cnt[key]!}"
  IO.println s!"elemsOf avg ns={elemT / (b - a)}"

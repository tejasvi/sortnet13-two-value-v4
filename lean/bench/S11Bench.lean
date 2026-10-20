import S11Comp
open Sortnet.S11

/-- Step offsets by a scan. -/
def offsets (byte : Nat → Nat) (count : Nat) : Array Nat := Id.run do
  let mut a : Array Nat := Array.mkEmpty count
  let mut o := 4
  for _ in [0:count] do
    a := a.push o
    let w := byte o
    o := o + 4 + bmLen w + 8 * byte (o + 3)
  return a

unsafe def main (args : List String) : IO Unit := do
  let path := args[0]!
  let from_ := (args[1]? >>= String.toNat?).getD 0
  let upto := (args[2]? >>= String.toNat?)
  let chunk := (args[3]? >>= String.toNat?).getD 20000
  let t0 ← IO.monoMsNow
  let data ← IO.FS.readBinFile path
  let byte : Nat → Nat := fun i => (data.get! i).toNat
  let count := readNum byte 0 4
  let offs := offsets byte count
  let t1 ← IO.monoMsNow
  IO.println s!"bytes={data.size} steps={count} read+scan ms={t1 - t0}"
  let c : Cert := ⟨byte, fun s => offs.getD s 0⟩
  -- shared by all tasks: mark persistent so that reference counting does not contend
  let c ← Runtime.markPersistent c
  let hi := (upto.getD count).min count
  let mut tasks : Array (Task (Option Nat)) := #[]
  let mut lo := from_
  while lo < hi do
    let a := lo
    let b := (lo + chunk).min hi
    tasks := tasks.push (Task.spawn fun _ => Id.run do
      for s in [a:b] do
        if !c.checkStep s then return some s
      return none)
    lo := b
  let mut bad : Array Nat := #[]
  for t in tasks do
    if let some s := t.get then bad := bad.push s
  let t2 ← IO.monoMsNow
  IO.println s!"checked steps [{from_},{hi}) in {tasks.size} tasks, ms={t2 - t1}, first failures (one per chunk): {bad.toList.take 20}"
  let last := count - 1
  IO.println s!"last step: W={c.W last} Bd={c.Bd last} kind={c.kind last}"

import S13Comp
open Sortnet.Comp

def main (args : List String) : IO Unit := do
  let n := args[0]!.toNat!
  let L := args[1]!.toNat!
  let t0 ← IO.monoMsNow
  let S := search n L
  IO.println s!"n={n} L={L} states={S.size}"
  let t1 ← IO.monoMsNow
  IO.println s!"search ms={t1 - t0}"
  let ok := S.contains (initC n) && checkAll n L S
  let t2 ← IO.monoMsNow
  IO.println s!"check={ok} ms={t2 - t1}"
  -- goal states present?
  let goals := S.filter (fun k => !twoEntries n k)
  IO.println s!"states without two entries: {goals.size}"

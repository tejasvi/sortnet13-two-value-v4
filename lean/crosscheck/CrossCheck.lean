import S13.Defs
import S13Comp

/-!
Cross-check executable. Reads lines `N lo,hi lo,hi ...` (a generalized network on `N` channels) and
prints, using the definitions of `S13.Defs`, whether the network is top-two correct and the list of
`|W(x,y)|` (x, y in lexicographic order, x ≠ y), and the f-state computed by `Comp.stepC` from
`Comp.initC`.
-/

open Sortnet

instance {n : Nat} (net : GNetwork n) : Decidable net.Top2Correct := by
  unfold GNetwork.Top2Correct; infer_instance

def mkNet (n : Nat) : List (Nat × Nat) → Option (GNetwork n)
  | [] => some []
  | (a, b) :: rest =>
    if h : a < n ∧ b < n ∧ a ≠ b then
      (mkNet n rest).map fun r => ⟨⟨a, h.1⟩, ⟨b, h.2.1⟩, fun e => h.2.2 (Fin.mk.inj e)⟩ :: r
    else none

def process (line : String) : String := Id.run do
  let toks := (line.splitOn " ").filter (· ≠ "")
  match toks with
  | [] => return "EMPTY"
  | nt :: rest =>
    let n := nt.toNat!
    let pairs := rest.map fun t => match t.splitOn "," with
      | [a, b] => (a.toNat!, b.toNat!)
      | _ => (0, 0)
    match mkNet n pairs with
    | none => return "BAD"
    | some net =>
      let top2 := decide net.Top2Correct
      let mut ws : Array Nat := #[]
      for x in List.finRange n do
        for y in List.finRange n do
          if x ≠ y then ws := ws.push (net.W x y).length
      let mut s := Comp.initC n
      for (a, b) in pairs do
        s := Comp.stepC n a b s
      return s!"top2={if top2 then 1 else 0} W={" ".intercalate (ws.toList.map toString)} F={" ".intercalate (s.toList.map toString)}"

def main : IO Unit := do
  let stdin ← IO.getStdin
  let stdout ← IO.getStdout
  repeat
    let line ← stdin.getLine
    if line.isEmpty then break
    stdout.putStrLn (process line.trimAscii.toString)
    stdout.flush

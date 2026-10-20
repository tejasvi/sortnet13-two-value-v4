import Lean
import S13Kernel.Check

/-!
# Loading the certificate data

Commands that read the untrusted certificate files at elaboration time and add them as definitions
whose values are literal terms (built directly as `Expr`s, without elaborating numerals). The data
only enter the proof through the kernel checks in `S13Kernel.Chunks.*`, so nothing about these
commands needs to be trusted.

* `load_keys X from "f"`: `f` lists one key per line, in hexadecimal; `X : KT` is the trie of depth 17
  with key number `j` at the leaf addressed by the binary digits of `j`.
* `load_certs X from "f"`: `f` has one line per state, with entries `ci:sg:tg:j` (decimal,
  hexadecimal, hexadecimal, decimal); `X : List CertList`.
-/

open Lean Elab Command

namespace S13K

/-- Parse a hexadecimal string (digits `0-9`, `a-f`). -/
def parseHex (s : String) : Nat := Id.run do
  let mut acc := 0
  for c in s.toList do
    let d := if c.isDigit then c.toNat - '0'.toNat else c.toNat - 'a'.toNat + 10
    acc := acc * 16 + d
  return acc

/-- The trie of depth `d` holding the keys with numbers in `[lo, lo + 2 ^ d)`. -/
partial def trieE (keys : Array Nat) (lo d : Nat) : Expr :=
  if lo ≥ keys.size then mkConst ``KT.em
  else if d = 0 then mkApp (mkConst ``KT.lf) (mkRawNatLit keys[lo]!)
  else mkApp2 (mkConst ``KT.nd) (trieE keys lo (d - 1)) (trieE keys (lo + 2 ^ (d - 1)) (d - 1))

/-- Add a definition with the given value (no compilation; the kernel checks its type). -/
def addDefE (name : Name) (type value : Expr) : CommandElabM Unit :=
  liftCoreM <| addDecl <| Declaration.defnDecl
    { name, levelParams := [], type, value, hints := .abbrev, safety := .safe }

elab "load_keys " id:ident " from " s:str : command => do
  let content ← IO.FS.readFile s.getString
  let keys := ((content.splitOn "\n").filter (· ≠ "")).map parseHex |>.toArray
  if keys.size > 2 ^ 17 then throwError "too many keys"
  addDefE ((← getCurrNamespace) ++ id.getId) (mkConst ``KT) (trieE keys 0 17)

/-- `Prod.mk a b : α × β`. -/
def mkPairE (α β a b : Expr) : Expr := mkApp4 (mkConst ``Prod.mk [Level.zero, Level.zero]) α β a b

/-- A list literal. -/
def mkListE (α : Expr) (xs : List Expr) : Expr :=
  xs.foldr (fun x acc => mkApp3 (mkConst ``List.cons [Level.zero]) α x acc)
    (mkApp (mkConst ``List.nil [Level.zero]) α)

elab "load_certs " id:ident " from " s:str : command => do
  let content ← IO.FS.readFile s.getString
  let nat := mkConst ``Nat
  let p2 := mkApp2 (mkConst ``Prod [Level.zero, Level.zero]) nat nat
  let p3 := mkApp2 (mkConst ``Prod [Level.zero, Level.zero]) nat p2
  let p4 := mkApp2 (mkConst ``Prod [Level.zero, Level.zero]) nat p3
  let ceT := mkApp (mkConst ``List [Level.zero]) p4
  let mut ces : Array Expr := #[]
  let lines := content.splitOn "\n"
  let lines := if lines.getLast? == some "" then lines.dropLast else lines
  for line in lines do
    let ws := (line.splitOn " ").filter (· ≠ "")
    let es := ws.map fun w =>
      match w.splitOn ":" with
      | [ci, sg, tg, j] => mkPairE nat p3 (mkRawNatLit ci.toNat!)
          (mkPairE nat p2 (mkRawNatLit (parseHex sg))
            (mkPairE nat nat (mkRawNatLit (parseHex tg)) (mkRawNatLit j.toNat!)))
      | _ => mkRawNatLit 0
    ces := ces.push (mkListE p4 es)
  addDefE ((← getCurrNamespace) ++ id.getId) (mkApp (mkConst ``List [Level.zero]) ceT)
    (mkListE ceT ces.toList)

end S13K

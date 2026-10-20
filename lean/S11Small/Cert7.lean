import S11Comp
import S11Loader

/-! Harder's certificate for 7 channels (11197 characters). -/

load_cert_chunk Sortnet.S11Small.chunk7 "data/small/cert7.s7" 16764717169282290828

namespace Sortnet.S11Small

open Sortnet.S11

def byte7 (i : Nat) : Nat :=
  if h : (⟨i⟩ : String.Pos.Raw) < chunk7.rawEndPos then (chunk7.getUTF8Byte ⟨i⟩ h).toNat else 0

def count7 : Nat := readNum byte7 0 4

def offsets7 : Array Nat := offsets byte7 count7

def cert7 : Cert := ⟨byte7, fun s => offsets7.getD s 0⟩

end Sortnet.S11Small

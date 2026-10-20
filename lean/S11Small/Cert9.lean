import S11Comp
import S11Loader

/-! Harder's certificate for 9 channels (1144181 characters). -/

load_cert_chunk Sortnet.S11Small.chunk9 "data/small/cert9.s7" 14556514100211714105

namespace Sortnet.S11Small

open Sortnet.S11

def byte9 (i : Nat) : Nat :=
  if h : (⟨i⟩ : String.Pos.Raw) < chunk9.rawEndPos then (chunk9.getUTF8Byte ⟨i⟩ h).toNat else 0

def count9 : Nat := readNum byte9 0 4

def offsets9 : Array Nat := offsets byte9 count9

def cert9 : Cert := ⟨byte9, fun s => offsets9.getD s 0⟩

end Sortnet.S11Small

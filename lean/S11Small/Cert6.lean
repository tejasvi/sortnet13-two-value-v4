import S11Comp
import S11Loader

/-! Harder's certificate for 6 channels (992 characters). -/

load_cert_chunk Sortnet.S11Small.chunk6 "data/small/cert6.s7" 691543652561490593

namespace Sortnet.S11Small

open Sortnet.S11

def byte6 (i : Nat) : Nat :=
  if h : (⟨i⟩ : String.Pos.Raw) < chunk6.rawEndPos then (chunk6.getUTF8Byte ⟨i⟩ h).toNat else 0

def count6 : Nat := readNum byte6 0 4

def offsets6 : Array Nat := offsets byte6 count6

def cert6 : Cert := ⟨byte6, fun s => offsets6.getD s 0⟩

end Sortnet.S11Small

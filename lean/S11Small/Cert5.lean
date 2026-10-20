import S11Comp
import S11Loader

/-! Harder's certificate for 5 channels (930 characters). -/

load_cert_chunk Sortnet.S11Small.chunk5 "data/small/cert5.s7" 15627166195903175780

namespace Sortnet.S11Small

open Sortnet.S11

def byte5 (i : Nat) : Nat :=
  if h : (⟨i⟩ : String.Pos.Raw) < chunk5.rawEndPos then (chunk5.getUTF8Byte ⟨i⟩ h).toNat else 0

def count5 : Nat := readNum byte5 0 4

def offsets5 : Array Nat := offsets byte5 count5

def cert5 : Cert := ⟨byte5, fun s => offsets5.getD s 0⟩

end Sortnet.S11Small

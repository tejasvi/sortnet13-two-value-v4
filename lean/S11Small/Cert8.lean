import S11Comp
import S11Loader

/-! Harder's certificate for 8 channels (11555 characters). -/

load_cert_chunk Sortnet.S11Small.chunk8 "data/small/cert8.s7" 2138301935389475151

namespace Sortnet.S11Small

open Sortnet.S11

def byte8 (i : Nat) : Nat :=
  if h : (⟨i⟩ : String.Pos.Raw) < chunk8.rawEndPos then (chunk8.getUTF8Byte ⟨i⟩ h).toNat else 0

def count8 : Nat := readNum byte8 0 4

def offsets8 : Array Nat := offsets byte8 count8

def cert8 : Cert := ⟨byte8, fun s => offsets8.getD s 0⟩

end Sortnet.S11Small

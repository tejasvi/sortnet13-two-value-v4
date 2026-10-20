import S11Comp
import S11Loader

/-! Harder's certificate for 10 channels (1133048 characters). -/

load_cert_chunk Sortnet.S11Small.chunk10 "data/small/cert10.s7" 15896360468567697273

namespace Sortnet.S11Small

open Sortnet.S11

def byte10 (i : Nat) : Nat :=
  if h : (⟨i⟩ : String.Pos.Raw) < chunk10.rawEndPos then (chunk10.getUTF8Byte ⟨i⟩ h).toNat else 0

def count10 : Nat := readNum byte10 0 4

def offsets10 : Array Nat := offsets byte10 count10

def cert10 : Cert := ⟨byte10, fun s => offsets10.getD s 0⟩

end Sortnet.S11Small

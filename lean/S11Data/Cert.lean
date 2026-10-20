import S11Comp
import S11Data.Chunk00
import S11Data.Chunk01
import S11Data.Chunk02
import S11Data.Chunk03
import S11Data.Chunk04
import S11Data.Chunk05
import S11Data.Chunk06
import S11Data.Chunk07
import S11Data.Chunk08
import S11Data.Chunk09
import S11Data.Chunk10
import S11Data.Chunk11
import S11Data.Chunk12
import S11Data.Chunk13
import S11Data.Chunk14
import S11Data.Chunk15
import S11Data.Chunk16
import S11Data.Chunk17
import S11Data.Chunk18
import S11Data.Chunk19
import S11Data.Chunk20
import S11Data.Chunk21
import S11Data.Chunk22
import S11Data.Chunk23
import S11Data.Chunk24
import S11Data.Chunk25
import S11Data.Chunk26
import S11Data.Chunk27
import S11Data.Chunk28
import S11Data.Chunk29
import S11Data.Chunk30
import S11Data.Chunk31
import S11Data.Chunk32

/-!
# The certificate for `S(11) ≥ 35`

Harder's certificate, converted to the format of `S11Comp` (`scripts/s11_data.sh`), split into
33 chunks of at most 64 MiB, which are loaded at build time (`S11Data.Loader`).
-/

namespace Sortnet.S11Data

open Sortnet.S11

/-- Characters per chunk. -/
def chunkSize : Nat := 67108864

/-- The chunks of the certificate. -/
def chunks : Array String := #[chunk00, chunk01, chunk02, chunk03, chunk04, chunk05, chunk06, chunk07, chunk08, chunk09, chunk10, chunk11, chunk12, chunk13, chunk14, chunk15, chunk16, chunk17, chunk18, chunk19, chunk20, chunk21, chunk22, chunk23, chunk24, chunk25, chunk26, chunk27, chunk28, chunk29, chunk30, chunk31, chunk32]

/-- Character `i` of the certificate (`0` beyond its end). -/
def certByte (i : Nat) : Nat :=
  match chunks[i / chunkSize]? with
  | some s =>
    let off := i % chunkSize
    if h : (⟨off⟩ : String.Pos.Raw) < s.rawEndPos then (s.getUTF8Byte ⟨off⟩ h).toNat else 0
  | none => 0

/-- The number of steps. -/
def certCount : Nat := readNum certByte 0 4

/-- The step offsets. -/
def certOffsets : Array Nat := offsets certByte certCount

/-- The certificate. -/
def theCert : Cert := ⟨certByte, fun s => certOffsets.getD s 0⟩

end Sortnet.S11Data

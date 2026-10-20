import S13Kernel.Data.Keys

/-! Keys number 37346 to 37425. `data/c/c00478.txt` has sha256 a017edde2692c6b10f0ab895626cec19ca5462442cb77a885b093bb573c570cd. -/

namespace S13K.Chunks.C00478

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00478.txt"

theorem chk : chkChunk S N 37346 80 ces = true := by decide +kernel

theorem ok : RangeOK S N 37346 37426 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00478

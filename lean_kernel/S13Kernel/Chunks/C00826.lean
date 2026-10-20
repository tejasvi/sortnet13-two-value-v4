import S13Kernel.Data.Keys

/-! Keys number 70245 to 70363. `data/c/c00826.txt` has sha256 51a4359181bc31e52cae945a4c15bba06ee46bf38e154ab09aebe01f80edd4d1. -/

namespace S13K.Chunks.C00826

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00826.txt"

theorem chk : chkChunk S N 70245 119 ces = true := by decide +kernel

theorem ok : RangeOK S N 70245 70364 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00826

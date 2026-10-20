import S13Kernel.Data.Keys

/-! Keys number 49276 to 49368. `data/c/c00606.txt` has sha256 8c56aaff25c8c2d8fed1e281790cd8447d334b5ce5cdb418fba64511fb97bc88. -/

namespace S13K.Chunks.C00606

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00606.txt"

theorem chk : chkChunk S N 49276 93 ces = true := by decide +kernel

theorem ok : RangeOK S N 49276 49369 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00606

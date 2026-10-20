import S13Kernel.Data.Keys

/-! Keys number 44973 to 45064. `data/c/c00559.txt` has sha256 62627a00604d1eb354edcb9c7d6594289f096dd85a72b4162357d5eb81cdb636. -/

namespace S13K.Chunks.C00559

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00559.txt"

theorem chk : chkChunk S N 44973 92 ces = true := by decide +kernel

theorem ok : RangeOK S N 44973 45065 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00559

import S13Kernel.Data.Keys

/-! Keys number 33404 to 33474. `data/c/c00431.txt` has sha256 3209752894b0b609b9d18927116c6f9761e6ce2d601ade8b7bff18ea0d9cf924. -/

namespace S13K.Chunks.C00431

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00431.txt"

theorem chk : chkChunk S N 33404 71 ces = true := by decide +kernel

theorem ok : RangeOK S N 33404 33475 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00431

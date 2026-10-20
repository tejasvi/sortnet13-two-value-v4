import S13Kernel.Data.Keys

/-! Keys number 13536 to 13613. `data/c/c00199.txt` has sha256 30db9f0dd1029bf061fab8d4efa96d5c6ebc102ef29d29bdaf5ddeda7916c726. -/

namespace S13K.Chunks.C00199

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00199.txt"

theorem chk : chkChunk S N 13536 78 ces = true := by decide +kernel

theorem ok : RangeOK S N 13536 13614 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00199

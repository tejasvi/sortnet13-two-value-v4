import S13Kernel.Data.Keys

/-! Keys number 5807 to 5877. `data/c/c00098.txt` has sha256 cf273a4ac3883b6fbd87097ccf4fbedd7db7c5914516f8ed08babb260c7ea0a0. -/

namespace S13K.Chunks.C00098

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00098.txt"

theorem chk : chkChunk S N 5807 71 ces = true := by decide +kernel

theorem ok : RangeOK S N 5807 5878 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00098

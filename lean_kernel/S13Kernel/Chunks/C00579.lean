import S13Kernel.Data.Keys

/-! Keys number 46834 to 46931. `data/c/c00579.txt` has sha256 e919c590e6414dc400a734ab1ca68c2538a162fe9ae9bed639a213caaac52da5. -/

namespace S13K.Chunks.C00579

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00579.txt"

theorem chk : chkChunk S N 46834 98 ces = true := by decide +kernel

theorem ok : RangeOK S N 46834 46932 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00579

import S13Kernel.Data.Keys

/-! Keys number 66897 to 66974. `data/c/c00792.txt` has sha256 bff940021d985acdae5e1ce241b51ea9041b831aa2766bda83bc8d9e3f79ce4f. -/

namespace S13K.Chunks.C00792

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00792.txt"

theorem chk : chkChunk S N 66897 78 ces = true := by decide +kernel

theorem ok : RangeOK S N 66897 66975 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00792

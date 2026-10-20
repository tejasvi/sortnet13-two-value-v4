import S13Kernel.Data.Keys

/-! Keys number 3252 to 3314. `data/c/c00059.txt` has sha256 8eed432d2e4dcdb694aeb8944887732174814ae0cffd4ac70fec6f7a98a7b6b6. -/

namespace S13K.Chunks.C00059

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00059.txt"

theorem chk : chkChunk S N 3252 63 ces = true := by decide +kernel

theorem ok : RangeOK S N 3252 3315 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00059

import S13Kernel.Data.Keys

/-! Keys number 77129 to 77232. `data/c/c00895.txt` has sha256 c9fab3059ffe9679e280817de2353df6b4d17988bd10452a8603ad40d32e337f. -/

namespace S13K.Chunks.C00895

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00895.txt"

theorem chk : chkChunk S N 77129 104 ces = true := by decide +kernel

theorem ok : RangeOK S N 77129 77233 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00895

import S13Kernel.Data.Keys

/-! Keys number 66802 to 66896. `data/c/c00791.txt` has sha256 a1a55efd915025c31df5a506fb09fc8fcfe695df126b79b761f587271946ced9. -/

namespace S13K.Chunks.C00791

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00791.txt"

theorem chk : chkChunk S N 66802 95 ces = true := by decide +kernel

theorem ok : RangeOK S N 66802 66897 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00791

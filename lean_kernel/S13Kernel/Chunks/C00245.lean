import S13Kernel.Data.Keys

/-! Keys number 17401 to 17502. `data/c/c00245.txt` has sha256 304e4a9a454c84604d43680b27527d41e5a80f0db7bd3ad0901001137e5bab18. -/

namespace S13K.Chunks.C00245

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00245.txt"

theorem chk : chkChunk S N 17401 102 ces = true := by decide +kernel

theorem ok : RangeOK S N 17401 17503 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00245

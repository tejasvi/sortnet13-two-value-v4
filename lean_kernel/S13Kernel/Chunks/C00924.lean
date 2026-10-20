import S13Kernel.Data.Keys

/-! Keys number 80148 to 80268. `data/c/c00924.txt` has sha256 91af670803035f4bdad34a93e4b4e17c635f435e8ec9d09f98e7c62f9da5fc6c. -/

namespace S13K.Chunks.C00924

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00924.txt"

theorem chk : chkChunk S N 80148 121 ces = true := by decide +kernel

theorem ok : RangeOK S N 80148 80269 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00924

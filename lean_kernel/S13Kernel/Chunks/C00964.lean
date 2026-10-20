import S13Kernel.Data.Keys

/-! Keys number 84279 to 84383. `data/c/c00964.txt` has sha256 07f4784087193ca7a361ad0bbcfd802e996e2f0ae215848b929409f37e2b0598. -/

namespace S13K.Chunks.C00964

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00964.txt"

theorem chk : chkChunk S N 84279 105 ces = true := by decide +kernel

theorem ok : RangeOK S N 84279 84384 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00964

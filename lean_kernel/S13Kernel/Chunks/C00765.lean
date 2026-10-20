import S13Kernel.Data.Keys

/-! Keys number 64366 to 64465. `data/c/c00765.txt` has sha256 57bf63d950958d61a4958ef0991cdf0bff24324d4917230d0f851882678a60cc. -/

namespace S13K.Chunks.C00765

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00765.txt"

theorem chk : chkChunk S N 64366 100 ces = true := by decide +kernel

theorem ok : RangeOK S N 64366 64466 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00765

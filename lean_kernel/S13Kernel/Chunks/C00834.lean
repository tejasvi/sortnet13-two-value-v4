import S13Kernel.Data.Keys

/-! Keys number 70995 to 71099. `data/c/c00834.txt` has sha256 7603b71eacf6e8ced6cb7d6250c2c5024cb048f10fe197ecb398bf51fafce69e. -/

namespace S13K.Chunks.C00834

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00834.txt"

theorem chk : chkChunk S N 70995 105 ces = true := by decide +kernel

theorem ok : RangeOK S N 70995 71100 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00834

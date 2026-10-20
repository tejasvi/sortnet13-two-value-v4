import S13Kernel.Data.Keys

/-! Keys number 84995 to 85098. `data/c/c00971.txt` has sha256 40e74e7680aa116d118c11922c1523def96fa8b5d16b39d1656234032593fb85. -/

namespace S13K.Chunks.C00971

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00971.txt"

theorem chk : chkChunk S N 84995 104 ces = true := by decide +kernel

theorem ok : RangeOK S N 84995 85099 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00971

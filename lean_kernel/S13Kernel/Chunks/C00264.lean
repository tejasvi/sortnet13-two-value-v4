import S13Kernel.Data.Keys

/-! Keys number 19034 to 19121. `data/c/c00264.txt` has sha256 4f58cbe02b3a92ce80aef35f4216f858fd0b26f03bbb981712fa8f36af585656. -/

namespace S13K.Chunks.C00264

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00264.txt"

theorem chk : chkChunk S N 19034 88 ces = true := by decide +kernel

theorem ok : RangeOK S N 19034 19122 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00264

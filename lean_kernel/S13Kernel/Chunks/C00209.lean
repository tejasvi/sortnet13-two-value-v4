import S13Kernel.Data.Keys

/-! Keys number 14324 to 14379. `data/c/c00209.txt` has sha256 66bd4211e1b18ee8b1003e982799641d68439b29223a2271cc36ee923320bd5c. -/

namespace S13K.Chunks.C00209

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00209.txt"

theorem chk : chkChunk S N 14324 56 ces = true := by decide +kernel

theorem ok : RangeOK S N 14324 14380 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00209

import S13Kernel.Data.Keys

/-! Keys number 7243 to 7321. `data/c/c00117.txt` has sha256 68e1c9bd8165301f05dbfb3021715364f577f66290b06f459aea2b4b72991608. -/

namespace S13K.Chunks.C00117

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00117.txt"

theorem chk : chkChunk S N 7243 79 ces = true := by decide +kernel

theorem ok : RangeOK S N 7243 7322 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00117

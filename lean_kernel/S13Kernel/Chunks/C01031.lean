import S13Kernel.Data.Keys

/-! Keys number 91490 to 91597. `data/c/c01031.txt` has sha256 24ccc2f3de5ee42f3a63e4cc8a43a307decc1d8d4ae57e6ff5233d2a285a4d97. -/

namespace S13K.Chunks.C01031

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01031.txt"

theorem chk : chkChunk S N 91490 108 ces = true := by decide +kernel

theorem ok : RangeOK S N 91490 91598 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01031

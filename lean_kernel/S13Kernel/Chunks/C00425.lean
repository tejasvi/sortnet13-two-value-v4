import S13Kernel.Data.Keys

/-! Keys number 32941 to 33011. `data/c/c00425.txt` has sha256 2ee5f29c68ba0b3c6db920af4447889d0677a578c20174430c5862dd97f028f7. -/

namespace S13K.Chunks.C00425

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00425.txt"

theorem chk : chkChunk S N 32941 71 ces = true := by decide +kernel

theorem ok : RangeOK S N 32941 33012 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00425

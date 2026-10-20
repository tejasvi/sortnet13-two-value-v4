import S13Kernel.Data.Keys

/-! Keys number 37739 to 37852. `data/c/c00482.txt` has sha256 bbbb108cdacfb991f793c7a248d7402241b54175a08cedbce63cef78cc515cff. -/

namespace S13K.Chunks.C00482

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00482.txt"

theorem chk : chkChunk S N 37739 114 ces = true := by decide +kernel

theorem ok : RangeOK S N 37739 37853 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00482

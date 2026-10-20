import S13Kernel.Data.Keys

/-! Keys number 58928 to 59025. `data/c/c00711.txt` has sha256 3133b7a7841420db5a372ff61e4980d33b6535689ee0acc9550e95fc912397a7. -/

namespace S13K.Chunks.C00711

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00711.txt"

theorem chk : chkChunk S N 58928 98 ces = true := by decide +kernel

theorem ok : RangeOK S N 58928 59026 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00711

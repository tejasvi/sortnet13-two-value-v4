import S13Kernel.Data.Keys

/-! Keys number 34090 to 34168. `data/c/c00440.txt` has sha256 6c5030e36e4012daf2e5c694480b087d90681348e0d401d43a535908d128763b. -/

namespace S13K.Chunks.C00440

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00440.txt"

theorem chk : chkChunk S N 34090 79 ces = true := by decide +kernel

theorem ok : RangeOK S N 34090 34169 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00440

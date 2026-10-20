import S13Kernel.Data.Keys

/-! Keys number 93116 to 93230. `data/c/c01046.txt` has sha256 ff356c770e2c6b2e76e31e3cef3da5f1284896364c09262757daa2c594f21420. -/

namespace S13K.Chunks.C01046

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01046.txt"

theorem chk : chkChunk S N 93116 115 ces = true := by decide +kernel

theorem ok : RangeOK S N 93116 93231 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01046

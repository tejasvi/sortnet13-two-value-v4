import S13Kernel.Data.Keys

/-! Keys number 51956 to 52055. `data/c/c00637.txt` has sha256 4db934facc236a92e308ee4215d9a4e963e0190102b291f851c26264bea1ab45. -/

namespace S13K.Chunks.C00637

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00637.txt"

theorem chk : chkChunk S N 51956 100 ces = true := by decide +kernel

theorem ok : RangeOK S N 51956 52056 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00637

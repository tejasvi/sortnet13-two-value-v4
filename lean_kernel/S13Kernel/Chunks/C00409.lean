import S13Kernel.Data.Keys

/-! Keys number 31537 to 31634. `data/c/c00409.txt` has sha256 f2f577d66357c0bdd7f4765a0c25149cc226e97b9e88fa66905362b69d4e5172. -/

namespace S13K.Chunks.C00409

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00409.txt"

theorem chk : chkChunk S N 31537 98 ces = true := by decide +kernel

theorem ok : RangeOK S N 31537 31635 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00409

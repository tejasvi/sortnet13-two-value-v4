import S13Kernel.Data.Keys

/-! Keys number 66148 to 66243. `data/c/c00784.txt` has sha256 34551619a2fb2c087fcc5d066ab76f0f6d1dbb34e5d62f14d5cafc8dfb74e0f4. -/

namespace S13K.Chunks.C00784

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00784.txt"

theorem chk : chkChunk S N 66148 96 ces = true := by decide +kernel

theorem ok : RangeOK S N 66148 66244 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00784

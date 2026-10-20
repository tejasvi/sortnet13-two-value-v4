import S13Kernel.Data.Keys

/-! Keys number 93014 to 93115. `data/c/c01045.txt` has sha256 e58ff4ef1fbdb914748270f053627692778b429a4f3474b2b4f8268a8fe14b32. -/

namespace S13K.Chunks.C01045

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01045.txt"

theorem chk : chkChunk S N 93014 102 ces = true := by decide +kernel

theorem ok : RangeOK S N 93014 93116 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01045

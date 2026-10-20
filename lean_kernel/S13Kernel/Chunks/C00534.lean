import S13Kernel.Data.Keys

/-! Keys number 42507 to 42594. `data/c/c00534.txt` has sha256 8f735c511affd285c41f7722e084a7851ced7ec09167a648a970958166911e8c. -/

namespace S13K.Chunks.C00534

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00534.txt"

theorem chk : chkChunk S N 42507 88 ces = true := by decide +kernel

theorem ok : RangeOK S N 42507 42595 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00534

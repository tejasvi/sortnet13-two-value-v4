import S13Kernel.Data.Keys

/-! Keys number 6477 to 6561. `data/c/c00107.txt` has sha256 de0072a73c1534b8b70c5091901cc577c483bd28a8d13392f3b4e3cb3da59d09. -/

namespace S13K.Chunks.C00107

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00107.txt"

theorem chk : chkChunk S N 6477 85 ces = true := by decide +kernel

theorem ok : RangeOK S N 6477 6562 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00107

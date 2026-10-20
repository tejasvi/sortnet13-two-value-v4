import S13Kernel.Data.Keys

/-! Keys number 28967 to 29062. `data/c/c00381.txt` has sha256 acdfc96db3c649f3d293cb68a52369e0901b42b4ea9d9c90489452f1da37864d. -/

namespace S13K.Chunks.C00381

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00381.txt"

theorem chk : chkChunk S N 28967 96 ces = true := by decide +kernel

theorem ok : RangeOK S N 28967 29063 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00381

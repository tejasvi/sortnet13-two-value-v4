import S13Kernel.Data.Keys

/-! Keys number 66611 to 66704. `data/c/c00789.txt` has sha256 cc5d96d9d654a851fc95d2f0cf8c05de8b69a7cbc7ce2274cc5b9d7a388af942. -/

namespace S13K.Chunks.C00789

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00789.txt"

theorem chk : chkChunk S N 66611 94 ces = true := by decide +kernel

theorem ok : RangeOK S N 66611 66705 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00789

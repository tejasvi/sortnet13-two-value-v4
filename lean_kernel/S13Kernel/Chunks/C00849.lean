import S13Kernel.Data.Keys

/-! Keys number 72466 to 72559. `data/c/c00849.txt` has sha256 fdb1b7b916d1fb3d2d173e529f40fc58b6a983adfa64f2559fb0b6d6c6720fda. -/

namespace S13K.Chunks.C00849

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00849.txt"

theorem chk : chkChunk S N 72466 94 ces = true := by decide +kernel

theorem ok : RangeOK S N 72466 72560 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00849

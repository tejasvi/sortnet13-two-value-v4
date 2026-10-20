import S13Kernel.Data.Keys

/-! Keys number 82029 to 82128. `data/c/c00943.txt` has sha256 02c03724bb7d8460f645f633a9734d45c19f7dc6de0bfc2e3d207003e3ff9c88. -/

namespace S13K.Chunks.C00943

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00943.txt"

theorem chk : chkChunk S N 82029 100 ces = true := by decide +kernel

theorem ok : RangeOK S N 82029 82129 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00943

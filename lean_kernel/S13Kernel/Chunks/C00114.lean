import S13Kernel.Data.Keys

/-! Keys number 7051 to 7129. `data/c/c00114.txt` has sha256 6a565ec6388a58585bf2c427b8701cecb2ea27b4a5bfab908e3912844fb475e0. -/

namespace S13K.Chunks.C00114

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00114.txt"

theorem chk : chkChunk S N 7051 79 ces = true := by decide +kernel

theorem ok : RangeOK S N 7051 7130 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00114

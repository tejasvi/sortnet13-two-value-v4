import S13Kernel.Data.Keys

/-! Keys number 20084 to 20142. `data/c/c00277.txt` has sha256 02279534939db5eaa33226bb7c3d9fde5d1a03e3c7c6e4cf3da81d11f0a8f00f. -/

namespace S13K.Chunks.C00277

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00277.txt"

theorem chk : chkChunk S N 20084 59 ces = true := by decide +kernel

theorem ok : RangeOK S N 20084 20143 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00277

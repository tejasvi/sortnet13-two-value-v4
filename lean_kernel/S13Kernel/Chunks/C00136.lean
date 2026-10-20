import S13Kernel.Data.Keys

/-! Keys number 8691 to 8779. `data/c/c00136.txt` has sha256 67eaa3cb47c7de9612176cf7b0b12dfd9bdb770aa1e1fd6b356d794f8b282b17. -/

namespace S13K.Chunks.C00136

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00136.txt"

theorem chk : chkChunk S N 8691 89 ces = true := by decide +kernel

theorem ok : RangeOK S N 8691 8780 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00136

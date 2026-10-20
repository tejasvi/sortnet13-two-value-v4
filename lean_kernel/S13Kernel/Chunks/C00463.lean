import S13Kernel.Data.Keys

/-! Keys number 36037 to 36121. `data/c/c00463.txt` has sha256 75f9777e0f6691f1ce2ff4845f9cc8e7e0b34cb8f1e114e3de8c55c3d016dca1. -/

namespace S13K.Chunks.C00463

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00463.txt"

theorem chk : chkChunk S N 36037 85 ces = true := by decide +kernel

theorem ok : RangeOK S N 36037 36122 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00463

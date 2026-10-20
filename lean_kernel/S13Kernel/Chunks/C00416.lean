import S13Kernel.Data.Keys

/-! Keys number 32159 to 32246. `data/c/c00416.txt` has sha256 ad0f8114c8bbde3d7f7649bb12a734436439ff027d468b69604b0542a3ffb6c8. -/

namespace S13K.Chunks.C00416

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00416.txt"

theorem chk : chkChunk S N 32159 88 ces = true := by decide +kernel

theorem ok : RangeOK S N 32159 32247 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00416

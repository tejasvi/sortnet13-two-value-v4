import S13Kernel.Data.Keys

/-! Keys number 14122 to 14175. `data/c/c00206.txt` has sha256 b38d23962b0d10a755c525c036c5c5920c66f44571492537d71d11fb6bdd4a9b. -/

namespace S13K.Chunks.C00206

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00206.txt"

theorem chk : chkChunk S N 14122 54 ces = true := by decide +kernel

theorem ok : RangeOK S N 14122 14176 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00206

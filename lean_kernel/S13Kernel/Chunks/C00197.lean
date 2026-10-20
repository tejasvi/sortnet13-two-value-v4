import S13Kernel.Data.Keys

/-! Keys number 13352 to 13451. `data/c/c00197.txt` has sha256 24d02353f3f39cd1a988733401edca69677a6ae1fe1b99fc5f6b90b04360ab70. -/

namespace S13K.Chunks.C00197

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00197.txt"

theorem chk : chkChunk S N 13352 100 ces = true := by decide +kernel

theorem ok : RangeOK S N 13352 13452 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00197

import S13Kernel.Data.Keys

/-! Keys number 26285 to 26360. `data/c/c00352.txt` has sha256 d081f438c96c9cac5e8030a00a55b188f561cf0c51c951b14528e64b322a4161. -/

namespace S13K.Chunks.C00352

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00352.txt"

theorem chk : chkChunk S N 26285 76 ces = true := by decide +kernel

theorem ok : RangeOK S N 26285 26361 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00352

import S13Kernel.Data.Keys

/-! Keys number 38946 to 39033. `data/c/c00494.txt` has sha256 d78044f1256f61e3eb186d4dabffa1032ea5d33ab55511f09a50a08ccaa49b1d. -/

namespace S13K.Chunks.C00494

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00494.txt"

theorem chk : chkChunk S N 38946 88 ces = true := by decide +kernel

theorem ok : RangeOK S N 38946 39034 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00494

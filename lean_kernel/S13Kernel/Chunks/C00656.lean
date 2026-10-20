import S13Kernel.Data.Keys

/-! Keys number 53801 to 53882. `data/c/c00656.txt` has sha256 ada0d5d207ecc5516f9b7e88fab6788f58780026d4343100064928c22d571fa8. -/

namespace S13K.Chunks.C00656

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00656.txt"

theorem chk : chkChunk S N 53801 82 ces = true := by decide +kernel

theorem ok : RangeOK S N 53801 53883 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00656

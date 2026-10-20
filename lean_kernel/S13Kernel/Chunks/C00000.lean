import S13Kernel.Data.Keys

/-! Keys number 0 to 31. `data/c/c00000.txt` has sha256 4036facf45f5afccd75eb25e099f33f92dd00899a272ba21a5dbdc333810e7cb. -/

namespace S13K.Chunks.C00000

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00000.txt"

theorem chk : chkChunk S N 0 32 ces = true := by decide +kernel

theorem ok : RangeOK S N 0 32 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00000

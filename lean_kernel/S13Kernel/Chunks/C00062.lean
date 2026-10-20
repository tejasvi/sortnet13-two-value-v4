import S13Kernel.Data.Keys

/-! Keys number 3447 to 3494. `data/c/c00062.txt` has sha256 ad5525219de711b494bd3b47f11d7e2447ba382e1dcd0740f0a7b3abae451f52. -/

namespace S13K.Chunks.C00062

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00062.txt"

theorem chk : chkChunk S N 3447 48 ces = true := by decide +kernel

theorem ok : RangeOK S N 3447 3495 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00062

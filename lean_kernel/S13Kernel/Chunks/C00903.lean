import S13Kernel.Data.Keys

/-! Keys number 78018 to 78111. `data/c/c00903.txt` has sha256 e45b51cbc14fc17bd09de2294e0b20ad6b459f3c02ecb0fbba168aa50154fbce. -/

namespace S13K.Chunks.C00903

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00903.txt"

theorem chk : chkChunk S N 78018 94 ces = true := by decide +kernel

theorem ok : RangeOK S N 78018 78112 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00903

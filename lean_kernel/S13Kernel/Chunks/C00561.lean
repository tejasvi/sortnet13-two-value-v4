import S13Kernel.Data.Keys

/-! Keys number 45163 to 45250. `data/c/c00561.txt` has sha256 9e65314a72d9310801523d116ce210e2cde396717773261b0741a7eaa6719355. -/

namespace S13K.Chunks.C00561

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00561.txt"

theorem chk : chkChunk S N 45163 88 ces = true := by decide +kernel

theorem ok : RangeOK S N 45163 45251 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00561

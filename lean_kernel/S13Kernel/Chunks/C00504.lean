import S13Kernel.Data.Keys

/-! Keys number 39785 to 39875. `data/c/c00504.txt` has sha256 abd923b30ef1cc83dd876adecc6f242f04253f416efa434c3b0dbbf789472cda. -/

namespace S13K.Chunks.C00504

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00504.txt"

theorem chk : chkChunk S N 39785 91 ces = true := by decide +kernel

theorem ok : RangeOK S N 39785 39876 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00504

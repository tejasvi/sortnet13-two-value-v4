import S13Kernel.Data.Keys

/-! Keys number 5192 to 5250. `data/c/c00087.txt` has sha256 b45ca718f758834460f683efab4f63368062ac36c082aac890575cf394bc4fc9. -/

namespace S13K.Chunks.C00087

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00087.txt"

theorem chk : chkChunk S N 5192 59 ces = true := by decide +kernel

theorem ok : RangeOK S N 5192 5251 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00087

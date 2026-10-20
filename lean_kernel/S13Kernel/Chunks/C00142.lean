import S13Kernel.Data.Keys

/-! Keys number 9187 to 9280. `data/c/c00142.txt` has sha256 33c0cfd74627efe91abf40917fd60b61f0fbe1c70b67573294918b5057ea281d. -/

namespace S13K.Chunks.C00142

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00142.txt"

theorem chk : chkChunk S N 9187 94 ces = true := by decide +kernel

theorem ok : RangeOK S N 9187 9281 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00142

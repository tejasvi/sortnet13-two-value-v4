import S13Kernel.Data.Keys

/-! Keys number 31812 to 31903. `data/c/c00412.txt` has sha256 3b24c4406b601ee0898a2beed57751aa276efacd5776c45465912344c57f40a7. -/

namespace S13K.Chunks.C00412

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00412.txt"

theorem chk : chkChunk S N 31812 92 ces = true := by decide +kernel

theorem ok : RangeOK S N 31812 31904 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00412

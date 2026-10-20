import S13Kernel.Data.Keys

/-! Keys number 36989 to 37062. `data/c/c00474.txt` has sha256 d3565d382ab2b879f98a76a2cc16a8d49148716a8c8febef26695734bbfbc900. -/

namespace S13K.Chunks.C00474

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00474.txt"

theorem chk : chkChunk S N 36989 74 ces = true := by decide +kernel

theorem ok : RangeOK S N 36989 37063 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00474

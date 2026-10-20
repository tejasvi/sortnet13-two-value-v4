import S13Kernel.Data.Keys

/-! Keys number 9917 to 9977. `data/c/c00151.txt` has sha256 be668d1ab15ec1be6f6f28fd4ad7c79ffd7fb006cdf174533fd7d1b4d3b70db7. -/

namespace S13K.Chunks.C00151

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00151.txt"

theorem chk : chkChunk S N 9917 61 ces = true := by decide +kernel

theorem ok : RangeOK S N 9917 9978 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00151

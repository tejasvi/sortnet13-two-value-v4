import S13Kernel.Data.Keys

/-! Keys number 90932 to 91040. `data/c/c01026.txt` has sha256 2d5d2e10704c2aff6e663e456a82008d68afd9a8eee6dc7e2729aa7a8934f73d. -/

namespace S13K.Chunks.C01026

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01026.txt"

theorem chk : chkChunk S N 90932 109 ces = true := by decide +kernel

theorem ok : RangeOK S N 90932 91041 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01026

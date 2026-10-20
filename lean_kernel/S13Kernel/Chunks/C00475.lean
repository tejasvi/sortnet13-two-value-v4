import S13Kernel.Data.Keys

/-! Keys number 37063 to 37145. `data/c/c00475.txt` has sha256 db9a49520e2b5a3dcedfdb9e12880a9994dca7a41391d9d12c64a42daf433514. -/

namespace S13K.Chunks.C00475

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00475.txt"

theorem chk : chkChunk S N 37063 83 ces = true := by decide +kernel

theorem ok : RangeOK S N 37063 37146 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00475

import S13Kernel.Data.Keys

/-! Keys number 5939 to 5997. `data/c/c00100.txt` has sha256 b0286943104c26728f5c13f645bd25630be00705a8cc5ab05473cb6c3193359d. -/

namespace S13K.Chunks.C00100

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00100.txt"

theorem chk : chkChunk S N 5939 59 ces = true := by decide +kernel

theorem ok : RangeOK S N 5939 5998 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00100

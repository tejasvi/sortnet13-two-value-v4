import S13Kernel.Data.Keys

/-! Keys number 4977 to 5045. `data/c/c00084.txt` has sha256 0f4d1a4e330681d193358e0c30a82733e27f3334da3d9bcce3407b483cbdc970. -/

namespace S13K.Chunks.C00084

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00084.txt"

theorem chk : chkChunk S N 4977 69 ces = true := by decide +kernel

theorem ok : RangeOK S N 4977 5046 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00084

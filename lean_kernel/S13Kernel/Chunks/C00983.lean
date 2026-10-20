import S13Kernel.Data.Keys

/-! Keys number 86248 to 86347. `data/c/c00983.txt` has sha256 7524cf3de8806a221c2471fb995ad7147fe656debd0f78e3677158f2db63bf5c. -/

namespace S13K.Chunks.C00983

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00983.txt"

theorem chk : chkChunk S N 86248 100 ces = true := by decide +kernel

theorem ok : RangeOK S N 86248 86348 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00983

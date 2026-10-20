import S13Kernel.Data.Keys

/-! Keys number 34487 to 34565. `data/c/c00445.txt` has sha256 e8a9155bff6ffc296b3dea3430dd1dfcd176948b0c37c45bdb79a01b7713a2ff. -/

namespace S13K.Chunks.C00445

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00445.txt"

theorem chk : chkChunk S N 34487 79 ces = true := by decide +kernel

theorem ok : RangeOK S N 34487 34566 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00445

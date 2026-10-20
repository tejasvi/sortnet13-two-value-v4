import S13Kernel.Data.Keys

/-! Keys number 1479 to 1528. `data/c/c00030.txt` has sha256 ea161620d7613d9a03579efcff3038c8be442245f2ce6398ab0f02887972abfc. -/

namespace S13K.Chunks.C00030

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00030.txt"

theorem chk : chkChunk S N 1479 50 ces = true := by decide +kernel

theorem ok : RangeOK S N 1479 1529 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00030

import S13Kernel.Data.Keys

/-! Keys number 51777 to 51866. `data/c/c00635.txt` has sha256 ba9305e775fd095b2c51159ee97e0cc7f7403f1e2272a523ccb728dbc7cd7d31. -/

namespace S13K.Chunks.C00635

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00635.txt"

theorem chk : chkChunk S N 51777 90 ces = true := by decide +kernel

theorem ok : RangeOK S N 51777 51867 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00635

import S13Kernel.Data.Keys

/-! Keys number 1712 to 1772. `data/c/c00034.txt` has sha256 d547c30ef35abfddb9000f99dc73ea05418b13ed8b5d9a1533557788cf283f2a. -/

namespace S13K.Chunks.C00034

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00034.txt"

theorem chk : chkChunk S N 1712 61 ces = true := by decide +kernel

theorem ok : RangeOK S N 1712 1773 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00034

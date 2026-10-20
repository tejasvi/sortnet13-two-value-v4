import S13Kernel.Data.Keys

/-! Keys number 5634 to 5684. `data/c/c00095.txt` has sha256 71f478fc0fac22c62e78ff0ad478cf2dcb43fd22f8effd08e16674bc4fbd742b. -/

namespace S13K.Chunks.C00095

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00095.txt"

theorem chk : chkChunk S N 5634 51 ces = true := by decide +kernel

theorem ok : RangeOK S N 5634 5685 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00095

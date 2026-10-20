import S13Kernel.Data.Keys

/-! Keys number 1661 to 1711. `data/c/c00033.txt` has sha256 4a88347b459cd13b105032a0d8f9efb3c09eb9764131a97a2d3201ac5fd320b7. -/

namespace S13K.Chunks.C00033

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00033.txt"

theorem chk : chkChunk S N 1661 51 ces = true := by decide +kernel

theorem ok : RangeOK S N 1661 1712 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00033

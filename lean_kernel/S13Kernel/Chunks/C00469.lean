import S13Kernel.Data.Keys

/-! Keys number 36570 to 36659. `data/c/c00469.txt` has sha256 86e4a96549c8546713c3f53bc808651e63cc74a0da3f6b467370e12158dfc8bf. -/

namespace S13K.Chunks.C00469

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00469.txt"

theorem chk : chkChunk S N 36570 90 ces = true := by decide +kernel

theorem ok : RangeOK S N 36570 36660 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00469

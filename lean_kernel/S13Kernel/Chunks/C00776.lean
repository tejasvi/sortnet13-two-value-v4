import S13Kernel.Data.Keys

/-! Keys number 65455 to 65551. `data/c/c00776.txt` has sha256 821d8b99cc00289fbca84eab7c984d8613044f4258291b01cd1bcdd9fee9ec9f. -/

namespace S13K.Chunks.C00776

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00776.txt"

theorem chk : chkChunk S N 65455 97 ces = true := by decide +kernel

theorem ok : RangeOK S N 65455 65552 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00776

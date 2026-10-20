import S13Kernel.Data.Keys

/-! Keys number 34169 to 34254. `data/c/c00441.txt` has sha256 ea321b0231bbb92786960e7646223e61c81ed32880b6bdebb1aeaef43c271eef. -/

namespace S13K.Chunks.C00441

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00441.txt"

theorem chk : chkChunk S N 34169 86 ces = true := by decide +kernel

theorem ok : RangeOK S N 34169 34255 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00441

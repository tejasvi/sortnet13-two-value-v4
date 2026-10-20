import S13Kernel.Data.Keys

/-! Keys number 27335 to 27434. `data/c/c00364.txt` has sha256 69e79eac55ceb682bbf5d02059bf35d95b5936d0413f794715566e50b617dc74. -/

namespace S13K.Chunks.C00364

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00364.txt"

theorem chk : chkChunk S N 27335 100 ces = true := by decide +kernel

theorem ok : RangeOK S N 27335 27435 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00364

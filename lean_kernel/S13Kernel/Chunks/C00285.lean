import S13Kernel.Data.Keys

/-! Keys number 20650 to 20714. `data/c/c00285.txt` has sha256 6379cbba94f54f9c18e1b84a0465ffa835b64ec5f2aef9dc63fa183abbad6cda. -/

namespace S13K.Chunks.C00285

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00285.txt"

theorem chk : chkChunk S N 20650 65 ces = true := by decide +kernel

theorem ok : RangeOK S N 20650 20715 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00285

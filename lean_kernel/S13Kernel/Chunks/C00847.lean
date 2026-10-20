import S13Kernel.Data.Keys

/-! Keys number 72285 to 72370. `data/c/c00847.txt` has sha256 cce6edb343442182957fba506d9a1bdab542ad50dbdf2ff7f06246e787bc6e1b. -/

namespace S13K.Chunks.C00847

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00847.txt"

theorem chk : chkChunk S N 72285 86 ces = true := by decide +kernel

theorem ok : RangeOK S N 72285 72371 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00847

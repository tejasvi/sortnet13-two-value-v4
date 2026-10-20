import S13Kernel.Data.Keys

/-! Keys number 31170 to 31255. `data/c/c00405.txt` has sha256 2b6f7dff82446c4e1335f30d487e55b39fb931a950421973ddc233b570729fe8. -/

namespace S13K.Chunks.C00405

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00405.txt"

theorem chk : chkChunk S N 31170 86 ces = true := by decide +kernel

theorem ok : RangeOK S N 31170 31256 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00405

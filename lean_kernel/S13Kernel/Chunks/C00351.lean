import S13Kernel.Data.Keys

/-! Keys number 26204 to 26284. `data/c/c00351.txt` has sha256 4bc9e42cd5eb2824ba45a1cd40c72cf0cdb23f254159e8f20c3c7bb6cfc3af34. -/

namespace S13K.Chunks.C00351

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00351.txt"

theorem chk : chkChunk S N 26204 81 ces = true := by decide +kernel

theorem ok : RangeOK S N 26204 26285 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00351

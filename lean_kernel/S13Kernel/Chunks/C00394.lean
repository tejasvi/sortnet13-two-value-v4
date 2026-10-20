import S13Kernel.Data.Keys

/-! Keys number 30165 to 30263. `data/c/c00394.txt` has sha256 e284c1bddcf1fc3c17702dd1b181b35397c174311fdaa609824445b05707319c. -/

namespace S13K.Chunks.C00394

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00394.txt"

theorem chk : chkChunk S N 30165 99 ces = true := by decide +kernel

theorem ok : RangeOK S N 30165 30264 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00394

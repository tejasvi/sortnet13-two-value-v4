import S13Kernel.Data.Keys

/-! Keys number 19714 to 19803. `data/c/c00272.txt` has sha256 7db481be0d0a1ca537a8bcc008c4cbe1a19c1569dd088b5ef29a0dadb2b5de50. -/

namespace S13K.Chunks.C00272

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00272.txt"

theorem chk : chkChunk S N 19714 90 ces = true := by decide +kernel

theorem ok : RangeOK S N 19714 19804 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00272

import S13Kernel.Data.Keys

/-! Keys number 56262 to 56344. `data/c/c00682.txt` has sha256 e1d9fb5c5e936610bacfcf9d364a3513eb2b1e6070bf6095c5dcec85e7f31221. -/

namespace S13K.Chunks.C00682

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00682.txt"

theorem chk : chkChunk S N 56262 83 ces = true := by decide +kernel

theorem ok : RangeOK S N 56262 56345 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00682

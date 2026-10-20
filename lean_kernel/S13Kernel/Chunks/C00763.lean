import S13Kernel.Data.Keys

/-! Keys number 64172 to 64266. `data/c/c00763.txt` has sha256 0e3df79b717d858a009e37628ac2894c97515a5e0c1671db7b477a09809d26ed. -/

namespace S13K.Chunks.C00763

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00763.txt"

theorem chk : chkChunk S N 64172 95 ces = true := by decide +kernel

theorem ok : RangeOK S N 64172 64267 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00763

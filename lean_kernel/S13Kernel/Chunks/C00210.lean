import S13Kernel.Data.Keys

/-! Keys number 14380 to 14460. `data/c/c00210.txt` has sha256 c1dfb7590f20f82a445f2f1db90ef22c63faab3220d2f27801acd6467f6f9dc9. -/

namespace S13K.Chunks.C00210

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00210.txt"

theorem chk : chkChunk S N 14380 81 ces = true := by decide +kernel

theorem ok : RangeOK S N 14380 14461 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00210

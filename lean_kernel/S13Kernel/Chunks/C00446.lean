import S13Kernel.Data.Keys

/-! Keys number 34566 to 34638. `data/c/c00446.txt` has sha256 d2fcd8636ed2349015a234dccb894d6de7facc9d3d9eb2b84721fd8a1f4a74d2. -/

namespace S13K.Chunks.C00446

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00446.txt"

theorem chk : chkChunk S N 34566 73 ces = true := by decide +kernel

theorem ok : RangeOK S N 34566 34639 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00446

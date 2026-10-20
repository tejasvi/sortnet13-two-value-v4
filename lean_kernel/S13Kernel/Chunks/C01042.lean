import S13Kernel.Data.Keys

/-! Keys number 92669 to 92782. `data/c/c01042.txt` has sha256 7378a0919f4edc0115a7acc0f80af8226f5ce34768c514a61b63458c993037a6. -/

namespace S13K.Chunks.C01042

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01042.txt"

theorem chk : chkChunk S N 92669 114 ces = true := by decide +kernel

theorem ok : RangeOK S N 92669 92783 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01042

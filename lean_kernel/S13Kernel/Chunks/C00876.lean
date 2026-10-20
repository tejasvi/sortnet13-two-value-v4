import S13Kernel.Data.Keys

/-! Keys number 75097 to 75199. `data/c/c00876.txt` has sha256 7f64022bc66d7c95c5883690102469fc1e943a1e17aeb874d06288d5946dd483. -/

namespace S13K.Chunks.C00876

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00876.txt"

theorem chk : chkChunk S N 75097 103 ces = true := by decide +kernel

theorem ok : RangeOK S N 75097 75200 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00876

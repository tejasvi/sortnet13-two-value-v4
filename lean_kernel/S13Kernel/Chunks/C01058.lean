import S13Kernel.Data.Keys

/-! Keys number 94492 to 94603. `data/c/c01058.txt` has sha256 0b924bfb07b83163595d42d6decabc555a7a038bd405106cd67e5ee6d4bb4463. -/

namespace S13K.Chunks.C01058

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01058.txt"

theorem chk : chkChunk S N 94492 112 ces = true := by decide +kernel

theorem ok : RangeOK S N 94492 94604 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01058

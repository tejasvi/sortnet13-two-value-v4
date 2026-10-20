import S13Kernel.Data.Keys

/-! Keys number 4046 to 4119. `data/c/c00071.txt` has sha256 b1f4f26dbea2bf1b18569019dd1f8df64d40a5071cd38449ea132ddb431a8f8d. -/

namespace S13K.Chunks.C00071

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00071.txt"

theorem chk : chkChunk S N 4046 74 ces = true := by decide +kernel

theorem ok : RangeOK S N 4046 4120 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00071

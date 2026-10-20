import S13Kernel.Data.Keys

/-! Keys number 18178 to 18282. `data/c/c00254.txt` has sha256 ced0c4dca8533fb0547f8259514e38c7fd35a0d7586c9683dfb0d2ef98032936. -/

namespace S13K.Chunks.C00254

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00254.txt"

theorem chk : chkChunk S N 18178 105 ces = true := by decide +kernel

theorem ok : RangeOK S N 18178 18283 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00254

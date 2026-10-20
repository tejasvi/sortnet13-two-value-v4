import S13Kernel.Data.Keys

/-! Keys number 55995 to 56080. `data/c/c00679.txt` has sha256 e4c2f7b3d02fcd32248bbb7e3b9bc7445ffb41e9dd8cccc61f335d3c18ca8694. -/

namespace S13K.Chunks.C00679

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00679.txt"

theorem chk : chkChunk S N 55995 86 ces = true := by decide +kernel

theorem ok : RangeOK S N 55995 56081 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00679

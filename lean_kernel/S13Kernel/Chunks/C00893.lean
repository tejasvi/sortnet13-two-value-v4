import S13Kernel.Data.Keys

/-! Keys number 76919 to 77023. `data/c/c00893.txt` has sha256 d5826ad6f4e5894b68c283a275da755b97973fbe0ed6712b0c1c2136cd776f15. -/

namespace S13K.Chunks.C00893

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00893.txt"

theorem chk : chkChunk S N 76919 105 ces = true := by decide +kernel

theorem ok : RangeOK S N 76919 77024 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00893

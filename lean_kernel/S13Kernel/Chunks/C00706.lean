import S13Kernel.Data.Keys

/-! Keys number 58425 to 58528. `data/c/c00706.txt` has sha256 5b4433e83a7dc34cf9be3043d723d2b03ac21e624ed043f190923f6224668bf0. -/

namespace S13K.Chunks.C00706

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00706.txt"

theorem chk : chkChunk S N 58425 104 ces = true := by decide +kernel

theorem ok : RangeOK S N 58425 58529 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00706

import S13Kernel.Data.Keys

/-! Keys number 44132 to 44245. `data/c/c00550.txt` has sha256 922fd2257d0743e7e739791f5e1357b463ebaba676e19f677dd79b512455dc99. -/

namespace S13K.Chunks.C00550

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00550.txt"

theorem chk : chkChunk S N 44132 114 ces = true := by decide +kernel

theorem ok : RangeOK S N 44132 44246 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00550

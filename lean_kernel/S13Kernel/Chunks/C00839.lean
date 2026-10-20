import S13Kernel.Data.Keys

/-! Keys number 71540 to 71635. `data/c/c00839.txt` has sha256 f2a2aba687aa307ef893d3aa4fba1bce4f14f5104aaad8eafcd065dd1bc4292a. -/

namespace S13K.Chunks.C00839

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00839.txt"

theorem chk : chkChunk S N 71540 96 ces = true := by decide +kernel

theorem ok : RangeOK S N 71540 71636 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00839

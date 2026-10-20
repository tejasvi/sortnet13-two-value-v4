import S13Kernel.Data.Keys

/-! Keys number 80466 to 80557. `data/c/c00927.txt` has sha256 9878642fd186ae1be6894e6fbf7de530c27d45c41722a1f68c58fe82acb5b7e8. -/

namespace S13K.Chunks.C00927

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00927.txt"

theorem chk : chkChunk S N 80466 92 ces = true := by decide +kernel

theorem ok : RangeOK S N 80466 80558 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00927

import S13Kernel.Data.Keys

/-! Keys number 86547 to 86642. `data/c/c00986.txt` has sha256 a1f67e1dea3e46a7848cc8ad4b8a7ab31bb8c7ede4a92da2fa4ec4640c98e0d9. -/

namespace S13K.Chunks.C00986

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00986.txt"

theorem chk : chkChunk S N 86547 96 ces = true := by decide +kernel

theorem ok : RangeOK S N 86547 86643 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00986

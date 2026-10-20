import S13Kernel.Data.Keys

/-! Keys number 58529 to 58628. `data/c/c00707.txt` has sha256 c97c77ab6c6b9fc8eeaee8153dfb8be4529cc33da2a483b3cff8a95600878e82. -/

namespace S13K.Chunks.C00707

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00707.txt"

theorem chk : chkChunk S N 58529 100 ces = true := by decide +kernel

theorem ok : RangeOK S N 58529 58629 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00707

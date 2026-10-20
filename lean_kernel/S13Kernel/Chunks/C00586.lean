import S13Kernel.Data.Keys

/-! Keys number 47499 to 47589. `data/c/c00586.txt` has sha256 0c0c15761266d36ef43547bcf103354485b488f4acc830d0f4d7532e9dea8ca2. -/

namespace S13K.Chunks.C00586

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00586.txt"

theorem chk : chkChunk S N 47499 91 ces = true := by decide +kernel

theorem ok : RangeOK S N 47499 47590 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00586

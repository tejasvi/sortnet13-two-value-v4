import S13Kernel.Data.Keys

/-! Keys number 63993 to 64080. `data/c/c00761.txt` has sha256 07137e406aad80c48d176b12ee42463f7cb040eff03e4eb2324a396e123e56a5. -/

namespace S13K.Chunks.C00761

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00761.txt"

theorem chk : chkChunk S N 63993 88 ces = true := by decide +kernel

theorem ok : RangeOK S N 63993 64081 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00761

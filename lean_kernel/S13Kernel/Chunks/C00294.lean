import S13Kernel.Data.Keys

/-! Keys number 21284 to 21352. `data/c/c00294.txt` has sha256 d91415d1dbd7034e709d1bb5a737189ede94e555667e7cb86b4fc7e190d6d3a0. -/

namespace S13K.Chunks.C00294

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00294.txt"

theorem chk : chkChunk S N 21284 69 ces = true := by decide +kernel

theorem ok : RangeOK S N 21284 21353 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00294

import S13Kernel.Data.Keys

/-! Keys number 72371 to 72465. `data/c/c00848.txt` has sha256 cc60605198994ac3108474320bad413a6ab85d5230285f8c1f5ed9fa94ab72f2. -/

namespace S13K.Chunks.C00848

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00848.txt"

theorem chk : chkChunk S N 72371 95 ces = true := by decide +kernel

theorem ok : RangeOK S N 72371 72466 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00848

import S13Kernel.Data.Keys

/-! Keys number 19288 to 19364. `data/c/c00267.txt` has sha256 0c765641a154fe3300304d36a62eff5f7b7491bf6d7e4b642ce1993c59e4d242. -/

namespace S13K.Chunks.C00267

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00267.txt"

theorem chk : chkChunk S N 19288 77 ces = true := by decide +kernel

theorem ok : RangeOK S N 19288 19365 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00267

import S13Kernel.Data.Keys

/-! Keys number 18371 to 18452. `data/c/c00256.txt` has sha256 558ff88e71e5978d00a149de28769a7bf22fa7bf7fb5a5b73656f7edd4d8fda7. -/

namespace S13K.Chunks.C00256

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00256.txt"

theorem chk : chkChunk S N 18371 82 ces = true := by decide +kernel

theorem ok : RangeOK S N 18371 18453 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00256

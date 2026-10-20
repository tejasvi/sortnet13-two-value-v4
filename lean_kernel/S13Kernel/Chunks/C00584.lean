import S13Kernel.Data.Keys

/-! Keys number 47322 to 47407. `data/c/c00584.txt` has sha256 a01448a377b27dbed419b9d2a0370177b7f93a855bba498b3f61f7d1c9b69252. -/

namespace S13K.Chunks.C00584

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00584.txt"

theorem chk : chkChunk S N 47322 86 ces = true := by decide +kernel

theorem ok : RangeOK S N 47322 47408 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00584

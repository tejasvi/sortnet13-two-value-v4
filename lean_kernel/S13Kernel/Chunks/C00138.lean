import S13Kernel.Data.Keys

/-! Keys number 8844 to 8922. `data/c/c00138.txt` has sha256 f663f425b9520587c60c77991608d1846ddcd5e63db9f2b5eee485d10b2e0f3c. -/

namespace S13K.Chunks.C00138

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00138.txt"

theorem chk : chkChunk S N 8844 79 ces = true := by decide +kernel

theorem ok : RangeOK S N 8844 8923 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00138

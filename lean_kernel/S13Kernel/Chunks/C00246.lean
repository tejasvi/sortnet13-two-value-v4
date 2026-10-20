import S13Kernel.Data.Keys

/-! Keys number 17503 to 17588. `data/c/c00246.txt` has sha256 1246f022f692cc96c381c44869444cf03713210d685ec8e8f3c8073334ba5073. -/

namespace S13K.Chunks.C00246

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00246.txt"

theorem chk : chkChunk S N 17503 86 ces = true := by decide +kernel

theorem ok : RangeOK S N 17503 17589 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00246

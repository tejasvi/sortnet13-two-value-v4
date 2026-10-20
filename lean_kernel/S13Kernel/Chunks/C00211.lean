import S13Kernel.Data.Keys

/-! Keys number 14461 to 14547. `data/c/c00211.txt` has sha256 125ba0cf0992a9fa1f79fcb99107ebc2b09276cfc943df27bf24aef32d5c5d49. -/

namespace S13K.Chunks.C00211

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00211.txt"

theorem chk : chkChunk S N 14461 87 ces = true := by decide +kernel

theorem ok : RangeOK S N 14461 14548 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00211

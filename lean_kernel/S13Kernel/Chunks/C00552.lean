import S13Kernel.Data.Keys

/-! Keys number 44340 to 44432. `data/c/c00552.txt` has sha256 4bdaa8d85c4deed1167d0f857c467d97ec94f3260f87e87b16666e0bba68d6aa. -/

namespace S13K.Chunks.C00552

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00552.txt"

theorem chk : chkChunk S N 44340 93 ces = true := by decide +kernel

theorem ok : RangeOK S N 44340 44433 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00552

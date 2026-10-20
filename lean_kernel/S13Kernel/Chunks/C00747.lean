import S13Kernel.Data.Keys

/-! Keys number 62649 to 62740. `data/c/c00747.txt` has sha256 bddedf68eab3e80d2088ca0a59ab6e45304661c572eefa3485ce49d6eaf41ab7. -/

namespace S13K.Chunks.C00747

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00747.txt"

theorem chk : chkChunk S N 62649 92 ces = true := by decide +kernel

theorem ok : RangeOK S N 62649 62741 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00747

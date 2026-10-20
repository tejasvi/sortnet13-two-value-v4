import S13Kernel.Data.Keys

/-! Keys number 68389 to 68487. `data/c/c00808.txt` has sha256 034ea82c10cc08247d0847eb07104a035dee146569f4b15bbb3812c9f7e5e1bd. -/

namespace S13K.Chunks.C00808

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00808.txt"

theorem chk : chkChunk S N 68389 99 ces = true := by decide +kernel

theorem ok : RangeOK S N 68389 68488 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00808

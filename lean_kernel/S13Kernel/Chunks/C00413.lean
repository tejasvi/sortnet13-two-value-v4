import S13Kernel.Data.Keys

/-! Keys number 31904 to 31977. `data/c/c00413.txt` has sha256 62b8951dbade4608cc081b3a403706f3cb54228d89733331cb6430b99464c612. -/

namespace S13K.Chunks.C00413

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00413.txt"

theorem chk : chkChunk S N 31904 74 ces = true := by decide +kernel

theorem ok : RangeOK S N 31904 31978 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00413

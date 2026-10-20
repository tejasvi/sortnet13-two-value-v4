import S13Kernel.Data.Keys

/-! Keys number 23372 to 23471. `data/c/c00319.txt` has sha256 5beeaa32d846543cca8c61d97133c0ec36849b74d4cc0db9b0ccfe8df3c933cb. -/

namespace S13K.Chunks.C00319

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00319.txt"

theorem chk : chkChunk S N 23372 100 ces = true := by decide +kernel

theorem ok : RangeOK S N 23372 23472 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00319

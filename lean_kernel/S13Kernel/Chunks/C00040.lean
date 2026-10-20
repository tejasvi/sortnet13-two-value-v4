import S13Kernel.Data.Keys

/-! Keys number 2097 to 2156. `data/c/c00040.txt` has sha256 4048db3bc287969da1c39cbc5c5c3a4bd02b292bc825cac936f80e92814b9395. -/

namespace S13K.Chunks.C00040

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00040.txt"

theorem chk : chkChunk S N 2097 60 ces = true := by decide +kernel

theorem ok : RangeOK S N 2097 2157 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00040

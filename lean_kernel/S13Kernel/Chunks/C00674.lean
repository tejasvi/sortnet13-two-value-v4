import S13Kernel.Data.Keys

/-! Keys number 55552 to 55632. `data/c/c00674.txt` has sha256 ca5a311121c46ea62a49711d00efb4c1f9300d4c9d06453d817e91b4a548cecd. -/

namespace S13K.Chunks.C00674

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00674.txt"

theorem chk : chkChunk S N 55552 81 ces = true := by decide +kernel

theorem ok : RangeOK S N 55552 55633 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00674

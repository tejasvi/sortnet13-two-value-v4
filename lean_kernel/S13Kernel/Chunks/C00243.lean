import S13Kernel.Data.Keys

/-! Keys number 17193 to 17294. `data/c/c00243.txt` has sha256 6c2344942c7d644ad77ccc682b8c82076cfcffeb9f2a473c7424dd24a9e983ef. -/

namespace S13K.Chunks.C00243

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00243.txt"

theorem chk : chkChunk S N 17193 102 ces = true := by decide +kernel

theorem ok : RangeOK S N 17193 17295 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00243

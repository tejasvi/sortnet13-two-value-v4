import S13Kernel.Data.Keys

/-! Keys number 11701 to 11776. `data/c/c00177.txt` has sha256 752099d9617292cbc0d2b12ef2f090dd3de9efd7926a2a1176e07e80bcd6e3b6. -/

namespace S13K.Chunks.C00177

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00177.txt"

theorem chk : chkChunk S N 11701 76 ces = true := by decide +kernel

theorem ok : RangeOK S N 11701 11777 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00177

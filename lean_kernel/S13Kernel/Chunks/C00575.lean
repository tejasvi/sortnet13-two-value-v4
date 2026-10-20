import S13Kernel.Data.Keys

/-! Keys number 46480 to 46556. `data/c/c00575.txt` has sha256 1d148eb5bbec882ae05e8c59cab5f24ecf666b786412bd7a35c9a8478c5fdee7. -/

namespace S13K.Chunks.C00575

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00575.txt"

theorem chk : chkChunk S N 46480 77 ces = true := by decide +kernel

theorem ok : RangeOK S N 46480 46557 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00575

import S13Kernel.Data.Keys

/-! Keys number 75991 to 76103. `data/c/c00884.txt` has sha256 f98a83782139617526ad7ceb6ef1886185edca14d03bfd1b7008afe2cc46bc76. -/

namespace S13K.Chunks.C00884

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00884.txt"

theorem chk : chkChunk S N 75991 113 ces = true := by decide +kernel

theorem ok : RangeOK S N 75991 76104 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00884

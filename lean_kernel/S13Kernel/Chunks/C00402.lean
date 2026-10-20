import S13Kernel.Data.Keys

/-! Keys number 30923 to 31007. `data/c/c00402.txt` has sha256 7e876f9da889449f6503724985188028bfd99270821fd0cbb5a86bc8af322fbc. -/

namespace S13K.Chunks.C00402

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00402.txt"

theorem chk : chkChunk S N 30923 85 ces = true := by decide +kernel

theorem ok : RangeOK S N 30923 31008 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00402

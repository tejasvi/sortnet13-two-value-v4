import S13Kernel.Data.Keys

/-! Keys number 6818 to 6892. `data/c/c00111.txt` has sha256 eda974da66ed0c63361cc0f352688c43eacbf72fed1b4d4c3fc62089c809ff97. -/

namespace S13K.Chunks.C00111

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00111.txt"

theorem chk : chkChunk S N 6818 75 ces = true := by decide +kernel

theorem ok : RangeOK S N 6818 6893 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00111

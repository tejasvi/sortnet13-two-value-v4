import S13Kernel.Data.Keys

/-! Keys number 86846 to 86952. `data/c/c00989.txt` has sha256 76624a3658c311e9b76aac2ec158e121958369af638764c1abe4c5aebde85fba. -/

namespace S13K.Chunks.C00989

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00989.txt"

theorem chk : chkChunk S N 86846 107 ces = true := by decide +kernel

theorem ok : RangeOK S N 86846 86953 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00989

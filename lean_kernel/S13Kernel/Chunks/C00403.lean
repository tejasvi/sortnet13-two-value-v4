import S13Kernel.Data.Keys

/-! Keys number 31008 to 31077. `data/c/c00403.txt` has sha256 92a228061d735897fa0dd3cd49698161ddbb81e35bf5bd66ce66166903beaadb. -/

namespace S13K.Chunks.C00403

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00403.txt"

theorem chk : chkChunk S N 31008 70 ces = true := by decide +kernel

theorem ok : RangeOK S N 31008 31078 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00403

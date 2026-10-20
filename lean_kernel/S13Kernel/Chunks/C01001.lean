import S13Kernel.Data.Keys

/-! Keys number 88122 to 88233. `data/c/c01001.txt` has sha256 09419be568e63585ef427b880cabcf2f5c3c950e911392e05c3bb500b4c63166. -/

namespace S13K.Chunks.C01001

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01001.txt"

theorem chk : chkChunk S N 88122 112 ces = true := by decide +kernel

theorem ok : RangeOK S N 88122 88234 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01001

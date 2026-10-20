import S13Kernel.Data.Keys

/-! Keys number 10749 to 10811. `data/c/c00162.txt` has sha256 00b0479a96519efb049b8231400bfbf9acb7c4fc9e4c918fa319dfdeedf43395. -/

namespace S13K.Chunks.C00162

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00162.txt"

theorem chk : chkChunk S N 10749 63 ces = true := by decide +kernel

theorem ok : RangeOK S N 10749 10812 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00162

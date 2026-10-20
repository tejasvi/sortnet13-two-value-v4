import S13Kernel.Data.Keys

/-! Keys number 73484 to 73585. `data/c/c00860.txt` has sha256 cef016ec791126e8f4e17f083d342ee0bb05a0636b86d38dd64e1827b3f00dc8. -/

namespace S13K.Chunks.C00860

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00860.txt"

theorem chk : chkChunk S N 73484 102 ces = true := by decide +kernel

theorem ok : RangeOK S N 73484 73586 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00860

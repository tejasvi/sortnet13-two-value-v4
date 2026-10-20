import S13Kernel.Data.Keys

/-! Keys number 83479 to 83593. `data/c/c00957.txt` has sha256 eec3e25c41c18adcaf7bbe91b754dbeaab08faa07e99ba4da48a1457dd64b8f6. -/

namespace S13K.Chunks.C00957

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00957.txt"

theorem chk : chkChunk S N 83479 115 ces = true := by decide +kernel

theorem ok : RangeOK S N 83479 83594 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00957

import S13Kernel.Data.Keys

/-! Keys number 92343 to 92447. `data/c/c01039.txt` has sha256 fc3b2db39ae69cec5c185a75c0d1c37823c8ea9ee811365127f46f780e7cb116. -/

namespace S13K.Chunks.C01039

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01039.txt"

theorem chk : chkChunk S N 92343 105 ces = true := by decide +kernel

theorem ok : RangeOK S N 92343 92448 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01039

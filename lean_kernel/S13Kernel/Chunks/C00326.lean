import S13Kernel.Data.Keys

/-! Keys number 24108 to 24194. `data/c/c00326.txt` has sha256 6b95b09e19cfbb0d79486a36dc958b57f36ae79263004d88ed8f447d7bc53eb0. -/

namespace S13K.Chunks.C00326

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00326.txt"

theorem chk : chkChunk S N 24108 87 ces = true := by decide +kernel

theorem ok : RangeOK S N 24108 24195 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00326

import S13Kernel.Data.Keys

/-! Keys number 46391 to 46479. `data/c/c00574.txt` has sha256 e161eaa4d2edab86da748704932606e3ba1529fc123eab04aaab3cc52f9a98c8. -/

namespace S13K.Chunks.C00574

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00574.txt"

theorem chk : chkChunk S N 46391 89 ces = true := by decide +kernel

theorem ok : RangeOK S N 46391 46480 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00574

import S13Kernel.Data.Keys

/-! Keys number 64466 to 64563. `data/c/c00766.txt` has sha256 cab676abb50e35c10bc25ba6aee20a6bad8e1483e69fb506b8003e7c9274c2ce. -/

namespace S13K.Chunks.C00766

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00766.txt"

theorem chk : chkChunk S N 64466 98 ces = true := by decide +kernel

theorem ok : RangeOK S N 64466 64564 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00766

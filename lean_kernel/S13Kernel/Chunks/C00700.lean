import S13Kernel.Data.Keys

/-! Keys number 57884 to 57976. `data/c/c00700.txt` has sha256 572ea289a07dba0fefd0d60a94ad8fcca1e11f7eef75b01071ae265210d7998f. -/

namespace S13K.Chunks.C00700

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00700.txt"

theorem chk : chkChunk S N 57884 93 ces = true := by decide +kernel

theorem ok : RangeOK S N 57884 57977 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00700

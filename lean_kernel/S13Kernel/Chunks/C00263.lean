import S13Kernel.Data.Keys

/-! Keys number 18938 to 19033. `data/c/c00263.txt` has sha256 2e8625fd34e165fd03d4bcec8872233c2f316ddacd83a97518801977c1007d8c. -/

namespace S13K.Chunks.C00263

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00263.txt"

theorem chk : chkChunk S N 18938 96 ces = true := by decide +kernel

theorem ok : RangeOK S N 18938 19034 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00263

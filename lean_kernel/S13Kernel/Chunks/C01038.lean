import S13Kernel.Data.Keys

/-! Keys number 92236 to 92342. `data/c/c01038.txt` has sha256 758dbee710283e18a634913ad1b446aac637f4ec300ff0d28a67f18273a74f8c. -/

namespace S13K.Chunks.C01038

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01038.txt"

theorem chk : chkChunk S N 92236 107 ces = true := by decide +kernel

theorem ok : RangeOK S N 92236 92343 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01038

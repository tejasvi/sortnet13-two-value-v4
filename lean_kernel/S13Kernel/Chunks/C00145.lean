import S13Kernel.Data.Keys

/-! Keys number 9438 to 9513. `data/c/c00145.txt` has sha256 7a4c6e89fc71148f1ae0447679326763b183cf92bf48ff7d2bd51b3e93175f8c. -/

namespace S13K.Chunks.C00145

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00145.txt"

theorem chk : chkChunk S N 9438 76 ces = true := by decide +kernel

theorem ok : RangeOK S N 9438 9514 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00145

import S13Kernel.Data.Keys

/-! Keys number 39876 to 39961. `data/c/c00505.txt` has sha256 91b48fcbf79382d409f236839ec786a2432b2a77dc34507e455708ae3643f628. -/

namespace S13K.Chunks.C00505

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00505.txt"

theorem chk : chkChunk S N 39876 86 ces = true := by decide +kernel

theorem ok : RangeOK S N 39876 39962 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00505

import S13Kernel.Data.Keys

/-! Keys number 2515 to 2565. `data/c/c00048.txt` has sha256 c858ee3b5da79ae7799c3ede1e8868216a11e4911b32f6b410ca674ba22f1c46. -/

namespace S13K.Chunks.C00048

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00048.txt"

theorem chk : chkChunk S N 2515 51 ces = true := by decide +kernel

theorem ok : RangeOK S N 2515 2566 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00048

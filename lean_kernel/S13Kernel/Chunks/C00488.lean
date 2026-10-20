import S13Kernel.Data.Keys

/-! Keys number 38425 to 38512. `data/c/c00488.txt` has sha256 0af4a2b16554761a67391559d26d9addee0a2cdd5dcdb8307344cc7d94e1f357. -/

namespace S13K.Chunks.C00488

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00488.txt"

theorem chk : chkChunk S N 38425 88 ces = true := by decide +kernel

theorem ok : RangeOK S N 38425 38513 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00488

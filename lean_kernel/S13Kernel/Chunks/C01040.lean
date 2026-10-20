import S13Kernel.Data.Keys

/-! Keys number 92448 to 92555. `data/c/c01040.txt` has sha256 2209c818b7feca777cec71bfc234bb524886c06dd04ede4e1362b8d3c48205f8. -/

namespace S13K.Chunks.C01040

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01040.txt"

theorem chk : chkChunk S N 92448 108 ces = true := by decide +kernel

theorem ok : RangeOK S N 92448 92556 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01040

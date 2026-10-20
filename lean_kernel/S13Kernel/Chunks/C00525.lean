import S13Kernel.Data.Keys

/-! Keys number 41643 to 41743. `data/c/c00525.txt` has sha256 63e511095d7f74dcc1a3f718f7f62d1fd2602d63fbbe6d2454c47b3e3a185d56. -/

namespace S13K.Chunks.C00525

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00525.txt"

theorem chk : chkChunk S N 41643 101 ces = true := by decide +kernel

theorem ok : RangeOK S N 41643 41744 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00525

import S13Kernel.Data.Keys

/-! Keys number 23576 to 23681. `data/c/c00321.txt` has sha256 a10da6dc0bff4e8df0a0c84c565eb6057b26a0bed2dda8ba35f06be0e0b1c247. -/

namespace S13K.Chunks.C00321

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00321.txt"

theorem chk : chkChunk S N 23576 106 ces = true := by decide +kernel

theorem ok : RangeOK S N 23576 23682 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00321

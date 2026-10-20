import S13Kernel.Data.Keys

/-! Keys number 51690 to 51776. `data/c/c00634.txt` has sha256 4a9a8bcc1b5f564cc2d8496cd91b52cd337b1684bcda8c21e740a9c3fd712079. -/

namespace S13K.Chunks.C00634

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00634.txt"

theorem chk : chkChunk S N 51690 87 ces = true := by decide +kernel

theorem ok : RangeOK S N 51690 51777 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00634

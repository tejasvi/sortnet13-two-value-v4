import S13Kernel.Data.Keys

/-! Keys number 42595 to 42680. `data/c/c00535.txt` has sha256 d26d93e1888283ef7861354e637ddd07b217fc2098e42d2d09cd37f6307e2f54. -/

namespace S13K.Chunks.C00535

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00535.txt"

theorem chk : chkChunk S N 42595 86 ces = true := by decide +kernel

theorem ok : RangeOK S N 42595 42681 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00535

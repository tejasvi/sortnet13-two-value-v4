import S13Kernel.Data.Keys

/-! Keys number 97400 to 97517. `data/c/c01083.txt` has sha256 e6a4362618d5197f2d9f190c4f85505853d61be21baf86e5a69a25e662a8d9a0. -/

namespace S13K.Chunks.C01083

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01083.txt"

theorem chk : chkChunk S N 97400 118 ces = true := by decide +kernel

theorem ok : RangeOK S N 97400 97518 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01083

import S13Kernel.Data.Keys

/-! Keys number 29989 to 30078. `data/c/c00392.txt` has sha256 7d4bb14b1082a30209342d4cba116c1df09601853fedc424f4f4ff84a2b7d179. -/

namespace S13K.Chunks.C00392

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00392.txt"

theorem chk : chkChunk S N 29989 90 ces = true := by decide +kernel

theorem ok : RangeOK S N 29989 30079 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00392

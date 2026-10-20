import S13Kernel.Data.Keys

/-! Keys number 12971 to 13067. `data/c/c00193.txt` has sha256 4ebf509fd4803cf917c5b49f7b1ef8a3eff4087465c187b6e2de6dbb5e293c05. -/

namespace S13K.Chunks.C00193

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00193.txt"

theorem chk : chkChunk S N 12971 97 ces = true := by decide +kernel

theorem ok : RangeOK S N 12971 13068 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00193

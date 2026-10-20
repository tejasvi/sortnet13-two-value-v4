import S13Kernel.Data.Keys

/-! Keys number 92783 to 92896. `data/c/c01043.txt` has sha256 b8ccade227c84d639708f10e95067198141705a1c82370e0fd3f03b48fd973be. -/

namespace S13K.Chunks.C01043

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01043.txt"

theorem chk : chkChunk S N 92783 114 ces = true := by decide +kernel

theorem ok : RangeOK S N 92783 92897 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01043

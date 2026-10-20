import S13Kernel.Data.Keys

/-! Keys number 90062 to 90167. `data/c/c01018.txt` has sha256 9cdcea77995c60b9dcdf9a4e7c8727e0bef010b7b2274196d34a869b6400fdc6. -/

namespace S13K.Chunks.C01018

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01018.txt"

theorem chk : chkChunk S N 90062 106 ces = true := by decide +kernel

theorem ok : RangeOK S N 90062 90168 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01018

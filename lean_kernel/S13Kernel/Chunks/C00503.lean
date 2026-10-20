import S13Kernel.Data.Keys

/-! Keys number 39689 to 39784. `data/c/c00503.txt` has sha256 16db2bfe108c150ed02ebab2b35360adea4e0879caf4bf4bfa11819442940ed5. -/

namespace S13K.Chunks.C00503

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00503.txt"

theorem chk : chkChunk S N 39689 96 ces = true := by decide +kernel

theorem ok : RangeOK S N 39689 39785 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00503

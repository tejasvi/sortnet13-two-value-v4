import S13Kernel.Data.Keys

/-! Keys number 43425 to 43524. `data/c/c00543.txt` has sha256 7cb8c5fec1916354bc847faca60ff40fdcb71207710304a74536140273bb3f1d. -/

namespace S13K.Chunks.C00543

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00543.txt"

theorem chk : chkChunk S N 43425 100 ces = true := by decide +kernel

theorem ok : RangeOK S N 43425 43525 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00543

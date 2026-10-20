import S13Kernel.Data.Keys

/-! Keys number 79329 to 79419. `data/c/c00916.txt` has sha256 4b418b9bc2e62dd45259337bfbcc9dade9f2e764bbbe205039b14eed176633cb. -/

namespace S13K.Chunks.C00916

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00916.txt"

theorem chk : chkChunk S N 79329 91 ces = true := by decide +kernel

theorem ok : RangeOK S N 79329 79420 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00916

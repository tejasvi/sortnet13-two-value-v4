import S13Kernel.Data.Keys

/-! Keys number 78999 to 79114. `data/c/c00913.txt` has sha256 32fcf22db2990049ef911266f501b30a5f1be1ea23c6dc6cfd40ca8947db98cc. -/

namespace S13K.Chunks.C00913

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00913.txt"

theorem chk : chkChunk S N 78999 116 ces = true := by decide +kernel

theorem ok : RangeOK S N 78999 79115 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00913

import S13Kernel.Data.Keys

/-! Keys number 38513 to 38604. `data/c/c00489.txt` has sha256 6cb0965be524a7b61d7c889200d8abc79e946e6d5ef374dfb539b670cfc3284f. -/

namespace S13K.Chunks.C00489

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00489.txt"

theorem chk : chkChunk S N 38513 92 ces = true := by decide +kernel

theorem ok : RangeOK S N 38513 38605 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00489

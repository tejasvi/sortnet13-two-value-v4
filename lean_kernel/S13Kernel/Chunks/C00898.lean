import S13Kernel.Data.Keys

/-! Keys number 77443 to 77550. `data/c/c00898.txt` has sha256 c28e14ca26aaf221f24031b67d7c782c8ac4968f17ac46d03c0c7891485df6ee. -/

namespace S13K.Chunks.C00898

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00898.txt"

theorem chk : chkChunk S N 77443 108 ces = true := by decide +kernel

theorem ok : RangeOK S N 77443 77551 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00898

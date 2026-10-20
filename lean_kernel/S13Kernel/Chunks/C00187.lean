import S13Kernel.Data.Keys

/-! Keys number 12431 to 12514. `data/c/c00187.txt` has sha256 8f461333f1c96c33e83eeec918b81be080534fcf29f2d0a3db6506498764fbce. -/

namespace S13K.Chunks.C00187

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00187.txt"

theorem chk : chkChunk S N 12431 84 ces = true := by decide +kernel

theorem ok : RangeOK S N 12431 12515 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00187

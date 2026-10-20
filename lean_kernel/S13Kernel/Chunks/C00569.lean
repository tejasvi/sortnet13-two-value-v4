import S13Kernel.Data.Keys

/-! Keys number 45963 to 46048. `data/c/c00569.txt` has sha256 1d45a74d9c30e6483b60cf7e9436b921aecdd3b10e86e3be728508179b77af83. -/

namespace S13K.Chunks.C00569

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00569.txt"

theorem chk : chkChunk S N 45963 86 ces = true := by decide +kernel

theorem ok : RangeOK S N 45963 46049 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00569

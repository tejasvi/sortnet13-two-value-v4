import S13Kernel.Data.Keys

/-! Keys number 78893 to 78998. `data/c/c00912.txt` has sha256 44eda46ffd0facc94404344f331763ea0deeb1bcb8134cfacc234c55dfc8b9d8. -/

namespace S13K.Chunks.C00912

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00912.txt"

theorem chk : chkChunk S N 78893 106 ces = true := by decide +kernel

theorem ok : RangeOK S N 78893 78999 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00912

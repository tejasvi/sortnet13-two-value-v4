import S13Kernel.Data.Keys

/-! Keys number 74252 to 74364. `data/c/c00868.txt` has sha256 ad8ded882efd89987417a5f66339da47c20e2d138782f64d8d6434427b21911e. -/

namespace S13K.Chunks.C00868

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00868.txt"

theorem chk : chkChunk S N 74252 113 ces = true := by decide +kernel

theorem ok : RangeOK S N 74252 74365 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00868

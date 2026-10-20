import S13Kernel.Data.Keys

/-! Keys number 6392 to 6476. `data/c/c00106.txt` has sha256 f817113defe9f129d936e0ab256c795e7952022faa3cd85de9c59c571e22c361. -/

namespace S13K.Chunks.C00106

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00106.txt"

theorem chk : chkChunk S N 6392 85 ces = true := by decide +kernel

theorem ok : RangeOK S N 6392 6477 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00106

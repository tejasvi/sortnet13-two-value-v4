import S13Kernel.Data.Keys

/-! Keys number 1062 to 1110. `data/c/c00023.txt` has sha256 090695d564421945a70e8e09e4866518f5762d24401b813120dbdd057c588f0c. -/

namespace S13K.Chunks.C00023

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00023.txt"

theorem chk : chkChunk S N 1062 49 ces = true := by decide +kernel

theorem ok : RangeOK S N 1062 1111 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00023

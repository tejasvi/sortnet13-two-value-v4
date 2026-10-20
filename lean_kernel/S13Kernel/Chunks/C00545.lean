import S13Kernel.Data.Keys

/-! Keys number 43622 to 43724. `data/c/c00545.txt` has sha256 654b9d81f49a2df992e20a0d2bdd9f25c908659a427824e3a79baf41f6bcb901. -/

namespace S13K.Chunks.C00545

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00545.txt"

theorem chk : chkChunk S N 43622 103 ces = true := by decide +kernel

theorem ok : RangeOK S N 43622 43725 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00545

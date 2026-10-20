import S13Kernel.Data.Keys

/-! Keys number 32334 to 32438. `data/c/c00418.txt` has sha256 266e333e6142eab5e5c37e0d1459d9e51bdc367b0530a94522a8f66146644b13. -/

namespace S13K.Chunks.C00418

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00418.txt"

theorem chk : chkChunk S N 32334 105 ces = true := by decide +kernel

theorem ok : RangeOK S N 32334 32439 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00418

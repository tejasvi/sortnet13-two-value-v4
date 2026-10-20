import S13Kernel.Data.Keys

/-! Keys number 78301 to 78392. `data/c/c00906.txt` has sha256 c2b190050fd38ab5f58213d7b0844f9dbaf61981f9d4e3edd9230eb69328fb13. -/

namespace S13K.Chunks.C00906

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00906.txt"

theorem chk : chkChunk S N 78301 92 ces = true := by decide +kernel

theorem ok : RangeOK S N 78301 78393 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00906

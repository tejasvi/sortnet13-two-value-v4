import S13Kernel.Data.Keys

/-! Keys number 25766 to 25849. `data/c/c00346.txt` has sha256 414ca8f289bb42dd57d55d50733168f2090b65b82af07961387d6e91b96a2e51. -/

namespace S13K.Chunks.C00346

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00346.txt"

theorem chk : chkChunk S N 25766 84 ces = true := by decide +kernel

theorem ok : RangeOK S N 25766 25850 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00346

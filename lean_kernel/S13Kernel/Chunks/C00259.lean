import S13Kernel.Data.Keys

/-! Keys number 18602 to 18673. `data/c/c00259.txt` has sha256 95fd8a0ca15e130232379a77199ab198cf24f2112cf243a239a7d64746f8e929. -/

namespace S13K.Chunks.C00259

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00259.txt"

theorem chk : chkChunk S N 18602 72 ces = true := by decide +kernel

theorem ok : RangeOK S N 18602 18674 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00259

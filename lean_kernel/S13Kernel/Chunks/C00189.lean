import S13Kernel.Data.Keys

/-! Keys number 12607 to 12704. `data/c/c00189.txt` has sha256 b98352f431e6dca43d01314fd8600fdc7a2983812541f46f10cc686495b8e9a8. -/

namespace S13K.Chunks.C00189

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00189.txt"

theorem chk : chkChunk S N 12607 98 ces = true := by decide +kernel

theorem ok : RangeOK S N 12607 12705 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00189

import S13Kernel.Data.Keys

/-! Keys number 26361 to 26465. `data/c/c00353.txt` has sha256 bb7dc0204471f85795bc7ea972ef7d418fbdec0ada79e9ac211875c8874a42d5. -/

namespace S13K.Chunks.C00353

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00353.txt"

theorem chk : chkChunk S N 26361 105 ces = true := by decide +kernel

theorem ok : RangeOK S N 26361 26466 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00353

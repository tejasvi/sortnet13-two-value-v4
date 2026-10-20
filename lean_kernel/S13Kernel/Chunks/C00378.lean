import S13Kernel.Data.Keys

/-! Keys number 28671 to 28759. `data/c/c00378.txt` has sha256 2e9ea1847d4fb28a7d6a6e821dd632cea4232db0a475c472fa9e1e8e43135ef2. -/

namespace S13K.Chunks.C00378

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00378.txt"

theorem chk : chkChunk S N 28671 89 ces = true := by decide +kernel

theorem ok : RangeOK S N 28671 28760 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00378

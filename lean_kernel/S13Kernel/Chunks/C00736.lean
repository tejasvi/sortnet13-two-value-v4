import S13Kernel.Data.Keys

/-! Keys number 61519 to 61620. `data/c/c00736.txt` has sha256 8d3b507d195a101cf3066cad84f44bf93a6ad103d2f771babde88171ab31d542. -/

namespace S13K.Chunks.C00736

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00736.txt"

theorem chk : chkChunk S N 61519 102 ces = true := by decide +kernel

theorem ok : RangeOK S N 61519 61621 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00736

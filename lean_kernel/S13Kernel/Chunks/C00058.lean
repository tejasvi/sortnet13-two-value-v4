import S13Kernel.Data.Keys

/-! Keys number 3183 to 3251. `data/c/c00058.txt` has sha256 b04075cc607b83e5e4573756727992d3d685a8515ed515ec57c315c99281ee61. -/

namespace S13K.Chunks.C00058

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00058.txt"

theorem chk : chkChunk S N 3183 69 ces = true := by decide +kernel

theorem ok : RangeOK S N 3183 3252 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00058

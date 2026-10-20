import S13Kernel.Data.Keys

/-! Keys number 7545 to 7612. `data/c/c00121.txt` has sha256 0df913d4d65297b2249226b90a77cdf1584e4ae9a18c2753712f62b6bd481b88. -/

namespace S13K.Chunks.C00121

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00121.txt"

theorem chk : chkChunk S N 7545 68 ces = true := by decide +kernel

theorem ok : RangeOK S N 7545 7613 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00121

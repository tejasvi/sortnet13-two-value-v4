import S13Kernel.Data.Keys

/-! Keys number 82438 to 82529. `data/c/c00947.txt` has sha256 4738a5b582bf11a8bfa6193adcf0585f3d8929ce16390e6e59c77fe552f0ae50. -/

namespace S13K.Chunks.C00947

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00947.txt"

theorem chk : chkChunk S N 82438 92 ces = true := by decide +kernel

theorem ok : RangeOK S N 82438 82530 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00947

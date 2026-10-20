import S13Kernel.Data.Keys

/-! Keys number 40744 to 40838. `data/c/c00515.txt` has sha256 92913fbb292678d7ca6dd075414ce714e7294fb1298b543069b07720d3a1aaca. -/

namespace S13K.Chunks.C00515

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00515.txt"

theorem chk : chkChunk S N 40744 95 ces = true := by decide +kernel

theorem ok : RangeOK S N 40744 40839 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00515

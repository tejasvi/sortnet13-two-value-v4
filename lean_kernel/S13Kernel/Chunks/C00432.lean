import S13Kernel.Data.Keys

/-! Keys number 33475 to 33543. `data/c/c00432.txt` has sha256 c763cb1a87db7789b4c0dab371c2e80274fe25e779d34630d3c1d05db568eed2. -/

namespace S13K.Chunks.C00432

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00432.txt"

theorem chk : chkChunk S N 33475 69 ces = true := by decide +kernel

theorem ok : RangeOK S N 33475 33544 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00432

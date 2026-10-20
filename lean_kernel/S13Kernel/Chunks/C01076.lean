import S13Kernel.Data.Keys

/-! Keys number 96581 to 96692. `data/c/c01076.txt` has sha256 327ca46a59979890d791d3a43adedd14c3fc609ead01ab9315eeccd437e0ff57. -/

namespace S13K.Chunks.C01076

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01076.txt"

theorem chk : chkChunk S N 96581 112 ces = true := by decide +kernel

theorem ok : RangeOK S N 96581 96693 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01076

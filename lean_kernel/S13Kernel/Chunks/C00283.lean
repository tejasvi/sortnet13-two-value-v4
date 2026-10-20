import S13Kernel.Data.Keys

/-! Keys number 20506 to 20575. `data/c/c00283.txt` has sha256 ebfc199bb05b3d8fccca8fd102aac71c1829e4bff01d3af4cf8390ab47b806ac. -/

namespace S13K.Chunks.C00283

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00283.txt"

theorem chk : chkChunk S N 20506 70 ces = true := by decide +kernel

theorem ok : RangeOK S N 20506 20576 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00283

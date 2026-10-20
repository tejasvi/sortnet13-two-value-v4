import S13Kernel.Data.Keys

/-! Keys number 30674 to 30758. `data/c/c00399.txt` has sha256 603ee64b4ce094b2ea2e74b1009c3d1b0a99168be6b6ece5e1f54bd523ac6b73. -/

namespace S13K.Chunks.C00399

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00399.txt"

theorem chk : chkChunk S N 30674 85 ces = true := by decide +kernel

theorem ok : RangeOK S N 30674 30759 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00399

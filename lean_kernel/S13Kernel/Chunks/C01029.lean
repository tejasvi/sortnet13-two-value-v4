import S13Kernel.Data.Keys

/-! Keys number 91258 to 91368. `data/c/c01029.txt` has sha256 60d83c0d3b1599e60388cfcc8f2c0d5a82bdfb82ba9f2d438702d0789e5d4ff9. -/

namespace S13K.Chunks.C01029

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01029.txt"

theorem chk : chkChunk S N 91258 111 ces = true := by decide +kernel

theorem ok : RangeOK S N 91258 91369 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01029

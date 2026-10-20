import S13Kernel.Data.Keys

/-! Keys number 57507 to 57599. `data/c/c00696.txt` has sha256 655fd2d4614b4f2ec17484f527d2cd1bf0facdbaf3b2f5add99d4c2c27eeeb8d. -/

namespace S13K.Chunks.C00696

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00696.txt"

theorem chk : chkChunk S N 57507 93 ces = true := by decide +kernel

theorem ok : RangeOK S N 57507 57600 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00696

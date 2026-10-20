import S13Kernel.Data.Keys

/-! Keys number 17823 to 17905. `data/c/c00250.txt` has sha256 d3ff1590a5494303c994f4975829e2d2fc24d11083f2768cefbbfbb5aff3aac1. -/

namespace S13K.Chunks.C00250

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00250.txt"

theorem chk : chkChunk S N 17823 83 ces = true := by decide +kernel

theorem ok : RangeOK S N 17823 17906 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00250

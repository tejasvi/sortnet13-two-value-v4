import S13Kernel.Data.Keys

/-! Keys number 29390 to 29482. `data/c/c00385.txt` has sha256 66dc85bb0e1856d3a21e10da02746c9e95f94c98f77c42f2ba19d15109d68c76. -/

namespace S13K.Chunks.C00385

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00385.txt"

theorem chk : chkChunk S N 29390 93 ces = true := by decide +kernel

theorem ok : RangeOK S N 29390 29483 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00385

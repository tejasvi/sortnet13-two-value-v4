import S13Kernel.Data.Keys

/-! Keys number 61045 to 61137. `data/c/c00731.txt` has sha256 730d74769ba7ade11727576c5bd0743272dd99da478e3507082c1fc50a7ce70e. -/

namespace S13K.Chunks.C00731

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00731.txt"

theorem chk : chkChunk S N 61045 93 ces = true := by decide +kernel

theorem ok : RangeOK S N 61045 61138 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00731

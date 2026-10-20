import S13Kernel.Data.Keys

/-! Keys number 35221 to 35309. `data/c/c00454.txt` has sha256 7ff8cf2f836866655e150297889459fc86c4f5bc8fa506df71c0040010272b7a. -/

namespace S13K.Chunks.C00454

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00454.txt"

theorem chk : chkChunk S N 35221 89 ces = true := by decide +kernel

theorem ok : RangeOK S N 35221 35310 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00454

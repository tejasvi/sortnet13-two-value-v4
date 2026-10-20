import S13Kernel.Data.Keys

/-! Keys number 16936 to 17011. `data/c/c00240.txt` has sha256 1b8981876885229879257ceba6f6328b1dcf758b966b547f876b40ec8c7087d8. -/

namespace S13K.Chunks.C00240

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00240.txt"

theorem chk : chkChunk S N 16936 76 ces = true := by decide +kernel

theorem ok : RangeOK S N 16936 17012 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00240

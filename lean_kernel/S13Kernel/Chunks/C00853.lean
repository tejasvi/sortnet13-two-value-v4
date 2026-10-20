import S13Kernel.Data.Keys

/-! Keys number 72836 to 72938. `data/c/c00853.txt` has sha256 8faaa502a5b19ff61063e8865b7f88b94ff769d197a6b0559c28286a83e69a40. -/

namespace S13K.Chunks.C00853

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00853.txt"

theorem chk : chkChunk S N 72836 103 ces = true := by decide +kernel

theorem ok : RangeOK S N 72836 72939 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00853

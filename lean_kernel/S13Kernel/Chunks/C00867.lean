import S13Kernel.Data.Keys

/-! Keys number 74140 to 74251. `data/c/c00867.txt` has sha256 cad47fbb399613e86d03c9276416420f7b29316eb5edb59fffdc8b30224d0cba. -/

namespace S13K.Chunks.C00867

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00867.txt"

theorem chk : chkChunk S N 74140 112 ces = true := by decide +kernel

theorem ok : RangeOK S N 74140 74252 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00867

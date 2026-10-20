import S13Kernel.Data.Keys

/-! Keys number 4632 to 4705. `data/c/c00079.txt` has sha256 ef6bef6dcb685e6acac98927dea82601987edcc1c41e4e59c555305701c700ce. -/

namespace S13K.Chunks.C00079

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00079.txt"

theorem chk : chkChunk S N 4632 74 ces = true := by decide +kernel

theorem ok : RangeOK S N 4632 4706 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00079

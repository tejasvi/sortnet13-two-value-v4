import S13Kernel.Data.Keys

/-! Keys number 8247 to 8324. `data/c/c00130.txt` has sha256 a14524b4ad923c5a2c12311b2ea1f455228329127b9f56b0ab3f92cf8a29b5b7. -/

namespace S13K.Chunks.C00130

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00130.txt"

theorem chk : chkChunk S N 8247 78 ces = true := by decide +kernel

theorem ok : RangeOK S N 8247 8325 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00130

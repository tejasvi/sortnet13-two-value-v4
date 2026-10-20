import S13Kernel.Data.Keys

/-! Keys number 36297 to 36384. `data/c/c00466.txt` has sha256 8c74ba2faeb1bda738c6473c49a7da68908cca8b9041df0254f8ab95fde24a10. -/

namespace S13K.Chunks.C00466

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00466.txt"

theorem chk : chkChunk S N 36297 88 ces = true := by decide +kernel

theorem ok : RangeOK S N 36297 36385 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00466

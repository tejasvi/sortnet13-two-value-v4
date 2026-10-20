import S13Kernel.Data.Keys

/-! Keys number 12515 to 12606. `data/c/c00188.txt` has sha256 f4b8237e759b11f5e8331ce4b66d9a166038150dfd2d00a705c2c7b800b956e6. -/

namespace S13K.Chunks.C00188

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00188.txt"

theorem chk : chkChunk S N 12515 92 ces = true := by decide +kernel

theorem ok : RangeOK S N 12515 12607 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00188

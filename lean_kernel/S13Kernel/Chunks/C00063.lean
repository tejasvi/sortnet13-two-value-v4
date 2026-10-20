import S13Kernel.Data.Keys

/-! Keys number 3495 to 3552. `data/c/c00063.txt` has sha256 5ab2ef46853f37462b46af9fd331180ab4a3218d0fb6cf8b45a8cb8433e97d4b. -/

namespace S13K.Chunks.C00063

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00063.txt"

theorem chk : chkChunk S N 3495 58 ces = true := by decide +kernel

theorem ok : RangeOK S N 3495 3553 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00063

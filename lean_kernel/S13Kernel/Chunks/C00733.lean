import S13Kernel.Data.Keys

/-! Keys number 61236 to 61329. `data/c/c00733.txt` has sha256 a6f77f8a9e007b170b48e052d63d6f5f7c6f09112a3b498bb1da6995c8d5428f. -/

namespace S13K.Chunks.C00733

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00733.txt"

theorem chk : chkChunk S N 61236 94 ces = true := by decide +kernel

theorem ok : RangeOK S N 61236 61330 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00733

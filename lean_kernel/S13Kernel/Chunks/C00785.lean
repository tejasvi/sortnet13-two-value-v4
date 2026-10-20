import S13Kernel.Data.Keys

/-! Keys number 66244 to 66327. `data/c/c00785.txt` has sha256 b62f39a7e17ad7bfc6e669913e5d7bda44bfc56289fa8041133ad959e504bb28. -/

namespace S13K.Chunks.C00785

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00785.txt"

theorem chk : chkChunk S N 66244 84 ces = true := by decide +kernel

theorem ok : RangeOK S N 66244 66328 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00785

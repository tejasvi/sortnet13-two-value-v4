import S13Kernel.Data.Keys

/-! Keys number 5514 to 5581. `data/c/c00093.txt` has sha256 5b7ddb0eeb3c581c8ede74cc644fd89c60f8fca701d7772a624efa362f0f9398. -/

namespace S13K.Chunks.C00093

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00093.txt"

theorem chk : chkChunk S N 5514 68 ces = true := by decide +kernel

theorem ok : RangeOK S N 5514 5582 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00093

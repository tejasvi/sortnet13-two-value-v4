import S13Kernel.Data.Keys

/-! Keys number 66328 to 66422. `data/c/c00786.txt` has sha256 8a6a301ab33092501b51268840816427ad7040c5b8355281f04da95ddf43935c. -/

namespace S13K.Chunks.C00786

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00786.txt"

theorem chk : chkChunk S N 66328 95 ces = true := by decide +kernel

theorem ok : RangeOK S N 66328 66423 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00786

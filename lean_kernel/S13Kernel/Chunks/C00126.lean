import S13Kernel.Data.Keys

/-! Keys number 7906 to 7989. `data/c/c00126.txt` has sha256 ee3941c9a84a6e72e6881c68d471c61ffa77d2fef89c4d50fc3ba78f34d5f08f. -/

namespace S13K.Chunks.C00126

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00126.txt"

theorem chk : chkChunk S N 7906 84 ces = true := by decide +kernel

theorem ok : RangeOK S N 7906 7990 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00126

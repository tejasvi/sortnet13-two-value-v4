import S13Kernel.Data.Keys

/-! Keys number 41261 to 41355. `data/c/c00521.txt` has sha256 5a38af11996368905064ddb7ccd5a131345ca9709f095a079b0f1abe07e8c50b. -/

namespace S13K.Chunks.C00521

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00521.txt"

theorem chk : chkChunk S N 41261 95 ces = true := by decide +kernel

theorem ok : RangeOK S N 41261 41356 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00521

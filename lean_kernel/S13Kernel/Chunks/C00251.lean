import S13Kernel.Data.Keys

/-! Keys number 17906 to 17989. `data/c/c00251.txt` has sha256 cec732325e35e386a87267691f9f5c16529e05c92c895df02112590425567e9b. -/

namespace S13K.Chunks.C00251

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00251.txt"

theorem chk : chkChunk S N 17906 84 ces = true := by decide +kernel

theorem ok : RangeOK S N 17906 17990 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00251

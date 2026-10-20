import S13Kernel.Data.Keys

/-! Keys number 39614 to 39688. `data/c/c00502.txt` has sha256 a60a521e70926e9e97582c28665afbfc438e6973a9a8634fcbf7cfa48dd223e3. -/

namespace S13K.Chunks.C00502

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00502.txt"

theorem chk : chkChunk S N 39614 75 ces = true := by decide +kernel

theorem ok : RangeOK S N 39614 39689 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00502

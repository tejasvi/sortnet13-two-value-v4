import S13Kernel.Data.Keys

/-! Keys number 69399 to 69513. `data/c/c00818.txt` has sha256 827cee30133c9d93f7b829c71aba546f8ae167fe88bb99d32a94795305fd753b. -/

namespace S13K.Chunks.C00818

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00818.txt"

theorem chk : chkChunk S N 69399 115 ces = true := by decide +kernel

theorem ok : RangeOK S N 69399 69514 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00818

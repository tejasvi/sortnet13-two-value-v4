import S13Kernel.Data.Keys

/-! Keys number 7815 to 7905. `data/c/c00125.txt` has sha256 e2a8289ebfe3eef61b0dd44aa4bdc2a64855c6ee9b5c32232317f1ddeaa6adf3. -/

namespace S13K.Chunks.C00125

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00125.txt"

theorem chk : chkChunk S N 7815 91 ces = true := by decide +kernel

theorem ok : RangeOK S N 7815 7906 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00125

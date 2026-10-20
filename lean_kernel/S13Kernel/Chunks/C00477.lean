import S13Kernel.Data.Keys

/-! Keys number 37245 to 37345. `data/c/c00477.txt` has sha256 e0ad1d5a9f8ffbc3e9557f9337ef5288a1971cfd6ac796b9fd5e38eef3cbd4fe. -/

namespace S13K.Chunks.C00477

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00477.txt"

theorem chk : chkChunk S N 37245 101 ces = true := by decide +kernel

theorem ok : RangeOK S N 37245 37346 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00477

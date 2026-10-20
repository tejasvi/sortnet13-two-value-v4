import S13Kernel.Data.Keys

/-! Keys number 5459 to 5513. `data/c/c00092.txt` has sha256 622ec4465e8e2d0e7678f5c107ab85179476d5374e5303cd0e7c623f35ab1b9b. -/

namespace S13K.Chunks.C00092

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00092.txt"

theorem chk : chkChunk S N 5459 55 ces = true := by decide +kernel

theorem ok : RangeOK S N 5459 5514 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00092

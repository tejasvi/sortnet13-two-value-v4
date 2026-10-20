import S13Kernel.Data.Keys

/-! Keys number 47034 to 47145. `data/c/c00581.txt` has sha256 20727fb4752f4793d6f820e79a875db6fae3beb694c6dbf5fb3f626c5a6c3a33. -/

namespace S13K.Chunks.C00581

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00581.txt"

theorem chk : chkChunk S N 47034 112 ces = true := by decide +kernel

theorem ok : RangeOK S N 47034 47146 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00581

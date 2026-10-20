import S13Kernel.Data.Keys

/-! Keys number 35401 to 35482. `data/c/c00456.txt` has sha256 a36a1963df714c196e488add9f430ecc2a6370d1514f76bc4af3a2636ac3f01e. -/

namespace S13K.Chunks.C00456

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00456.txt"

theorem chk : chkChunk S N 35401 82 ces = true := by decide +kernel

theorem ok : RangeOK S N 35401 35483 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00456

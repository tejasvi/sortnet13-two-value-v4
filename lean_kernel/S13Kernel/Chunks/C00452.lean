import S13Kernel.Data.Keys

/-! Keys number 35059 to 35139. `data/c/c00452.txt` has sha256 37962cd449426fac10a4a1797a75b015720404c4fc3d46cda6fb9b9c8320cdfe. -/

namespace S13K.Chunks.C00452

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00452.txt"

theorem chk : chkChunk S N 35059 81 ces = true := by decide +kernel

theorem ok : RangeOK S N 35059 35140 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00452

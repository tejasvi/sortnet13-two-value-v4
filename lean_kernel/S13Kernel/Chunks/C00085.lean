import S13Kernel.Data.Keys

/-! Keys number 5046 to 5119. `data/c/c00085.txt` has sha256 a681c1a09a8294805754b0d5a12104df5e06e57bd09d61251bc3c5c6a15ade97. -/

namespace S13K.Chunks.C00085

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00085.txt"

theorem chk : chkChunk S N 5046 74 ces = true := by decide +kernel

theorem ok : RangeOK S N 5046 5120 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00085

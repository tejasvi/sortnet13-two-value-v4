import S13Kernel.Data.Keys

/-! Keys number 59582 to 59694. `data/c/c00717.txt` has sha256 96b1404d01b0ac1a1d11c73b36a1b2c062a12ae175903cda65f22477699eb618. -/

namespace S13K.Chunks.C00717

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00717.txt"

theorem chk : chkChunk S N 59582 113 ces = true := by decide +kernel

theorem ok : RangeOK S N 59582 59695 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00717

import S13Kernel.Data.Keys

/-! Keys number 35483 to 35564. `data/c/c00457.txt` has sha256 e074f752d88355e998c87537a12f2aa0018b9ff6fa4d83e60bbc32e8665629d1. -/

namespace S13K.Chunks.C00457

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00457.txt"

theorem chk : chkChunk S N 35483 82 ces = true := by decide +kernel

theorem ok : RangeOK S N 35483 35565 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00457

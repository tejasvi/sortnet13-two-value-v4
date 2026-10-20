import S13Kernel.Data.Keys

/-! Keys number 31341 to 31430. `data/c/c00407.txt` has sha256 c3df93091976cb4ce71cb56c38e38c170a9671cab920abb1c55cc6f05318519a. -/

namespace S13K.Chunks.C00407

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00407.txt"

theorem chk : chkChunk S N 31341 90 ces = true := by decide +kernel

theorem ok : RangeOK S N 31341 31431 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00407

import S13Kernel.Data.Keys

/-! Keys number 97637 to 97750. `data/c/c01085.txt` has sha256 35f26599cb9b1d54c22d1296f5afd6a93019e60a460a6f73d2e6c696e8b0aa7e. -/

namespace S13K.Chunks.C01085

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01085.txt"

theorem chk : chkChunk S N 97637 114 ces = true := by decide +kernel

theorem ok : RangeOK S N 97637 97751 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01085

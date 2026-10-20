import S13Kernel.Data.Keys

/-! Keys number 71636 to 71726. `data/c/c00840.txt` has sha256 a76450f9c1bc5b614ec074b9526b3b16d389d5d4fe35d37657ea0f9877d605a2. -/

namespace S13K.Chunks.C00840

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00840.txt"

theorem chk : chkChunk S N 71636 91 ces = true := by decide +kernel

theorem ok : RangeOK S N 71636 71727 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00840

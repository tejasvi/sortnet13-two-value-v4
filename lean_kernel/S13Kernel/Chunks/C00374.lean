import S13Kernel.Data.Keys

/-! Keys number 28317 to 28419. `data/c/c00374.txt` has sha256 b1b9701bd1e3f7cae4ae59769f1d0adf4e0ec97c01da38865a5fc02784594c94. -/

namespace S13K.Chunks.C00374

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00374.txt"

theorem chk : chkChunk S N 28317 103 ces = true := by decide +kernel

theorem ok : RangeOK S N 28317 28420 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00374

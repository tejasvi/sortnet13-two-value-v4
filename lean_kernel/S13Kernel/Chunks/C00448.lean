import S13Kernel.Data.Keys

/-! Keys number 34715 to 34789. `data/c/c00448.txt` has sha256 59e861f09faf485449aa171c9330d4159d1be927eb29a48ce54a833b10a37741. -/

namespace S13K.Chunks.C00448

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00448.txt"

theorem chk : chkChunk S N 34715 75 ces = true := by decide +kernel

theorem ok : RangeOK S N 34715 34790 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00448

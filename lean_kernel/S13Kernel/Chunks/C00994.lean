import S13Kernel.Data.Keys

/-! Keys number 87375 to 87472. `data/c/c00994.txt` has sha256 0b638f1bc766134e264dd7d934ac98d77171f0162a927d297600b9fe6ebd0daf. -/

namespace S13K.Chunks.C00994

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00994.txt"

theorem chk : chkChunk S N 87375 98 ces = true := by decide +kernel

theorem ok : RangeOK S N 87375 87473 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00994

import S13Kernel.Data.Keys

/-! Keys number 66423 to 66520. `data/c/c00787.txt` has sha256 4809abe45243bfc970d42d9dd6f5e525bedc766e0cb948ffbfda51becd89238a. -/

namespace S13K.Chunks.C00787

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00787.txt"

theorem chk : chkChunk S N 66423 98 ces = true := by decide +kernel

theorem ok : RangeOK S N 66423 66521 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00787

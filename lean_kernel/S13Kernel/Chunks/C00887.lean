import S13Kernel.Data.Keys

/-! Keys number 76309 to 76409. `data/c/c00887.txt` has sha256 15fd1aee63f7640befdbee4743e32ebb52a72ba35a81fe8c4a077da0e075d5c4. -/

namespace S13K.Chunks.C00887

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00887.txt"

theorem chk : chkChunk S N 76309 101 ces = true := by decide +kernel

theorem ok : RangeOK S N 76309 76410 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00887

import S13Kernel.Data.Keys

/-! Keys number 93469 to 93593. `data/c/c01049.txt` has sha256 0edc9848d2e3af93512cffc615434484c94dda8f12de8bcd59f5d472afaa562b. -/

namespace S13K.Chunks.C01049

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01049.txt"

theorem chk : chkChunk S N 93469 125 ces = true := by decide +kernel

theorem ok : RangeOK S N 93469 93594 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01049

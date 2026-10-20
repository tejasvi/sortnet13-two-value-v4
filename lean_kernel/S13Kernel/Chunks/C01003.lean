import S13Kernel.Data.Keys

/-! Keys number 88358 to 88476. `data/c/c01003.txt` has sha256 bc245726ea785509b92203a8895343461b6a90d4359bb7150c1d1bb5b7daa121. -/

namespace S13K.Chunks.C01003

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01003.txt"

theorem chk : chkChunk S N 88358 119 ces = true := by decide +kernel

theorem ok : RangeOK S N 88358 88477 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01003

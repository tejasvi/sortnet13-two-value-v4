import S13Kernel.Data.Keys

/-! Keys number 34343 to 34429. `data/c/c00443.txt` has sha256 1c72b95cf5b5fde555f95e021c4c9898fdba077da36e484440c85e4f3bd4dc71. -/

namespace S13K.Chunks.C00443

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00443.txt"

theorem chk : chkChunk S N 34343 87 ces = true := by decide +kernel

theorem ok : RangeOK S N 34343 34430 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00443

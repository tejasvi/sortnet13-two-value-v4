import S13Kernel.Data.Keys

/-! Keys number 17589 to 17662. `data/c/c00247.txt` has sha256 8f23ac735a37be96961bbfa286049dee33c0ff5def41de1d17fa554781938d0d. -/

namespace S13K.Chunks.C00247

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00247.txt"

theorem chk : chkChunk S N 17589 74 ces = true := by decide +kernel

theorem ok : RangeOK S N 17589 17663 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00247

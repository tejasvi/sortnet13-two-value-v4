import S13Kernel.Data.Keys

/-! Keys number 69295 to 69398. `data/c/c00817.txt` has sha256 e10e529b01108eaa044f7cdfbb70d0e700281441d5f4b46aaa325fc27047bcf7. -/

namespace S13K.Chunks.C00817

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00817.txt"

theorem chk : chkChunk S N 69295 104 ces = true := by decide +kernel

theorem ok : RangeOK S N 69295 69399 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00817

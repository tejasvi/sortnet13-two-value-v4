import S13Kernel.Data.Keys

/-! Keys number 11580 to 11639. `data/c/c00175.txt` has sha256 8f9c3c94ac16434c5d1755f52a541d58ccabaa638d1c72f4e5c93a9b20be7adc. -/

namespace S13K.Chunks.C00175

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00175.txt"

theorem chk : chkChunk S N 11580 60 ces = true := by decide +kernel

theorem ok : RangeOK S N 11580 11640 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00175

import S13Kernel.Data.Keys

/-! Keys number 9281 to 9368. `data/c/c00143.txt` has sha256 4edb6d3eb72548912ec6101e44b5505f607fb978672c45bebe4ecfcd75c4ad33. -/

namespace S13K.Chunks.C00143

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00143.txt"

theorem chk : chkChunk S N 9281 88 ces = true := by decide +kernel

theorem ok : RangeOK S N 9281 9369 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00143

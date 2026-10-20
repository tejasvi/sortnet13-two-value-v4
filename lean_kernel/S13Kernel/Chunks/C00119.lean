import S13Kernel.Data.Keys

/-! Keys number 7397 to 7481. `data/c/c00119.txt` has sha256 d32c89f34cb5c5856588d1ea67c6370945234bdfc802567735cff153f75168ec. -/

namespace S13K.Chunks.C00119

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00119.txt"

theorem chk : chkChunk S N 7397 85 ces = true := by decide +kernel

theorem ok : RangeOK S N 7397 7482 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00119

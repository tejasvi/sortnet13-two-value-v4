import S13Kernel.Data.Keys

/-! Keys number 24005 to 24107. `data/c/c00325.txt` has sha256 4b64e0a69aa7ac2ea78b380dbec86855a24a75740df79fa7aa6c8d0242f39c1f. -/

namespace S13K.Chunks.C00325

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00325.txt"

theorem chk : chkChunk S N 24005 103 ces = true := by decide +kernel

theorem ok : RangeOK S N 24005 24108 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00325

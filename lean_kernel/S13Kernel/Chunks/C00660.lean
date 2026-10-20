import S13Kernel.Data.Keys

/-! Keys number 54150 to 54258. `data/c/c00660.txt` has sha256 afc2078b0632049036f3c847e1b3c3b206fa25bc237d21f1bcc089c086a9cb4a. -/

namespace S13K.Chunks.C00660

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00660.txt"

theorem chk : chkChunk S N 54150 109 ces = true := by decide +kernel

theorem ok : RangeOK S N 54150 54259 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00660

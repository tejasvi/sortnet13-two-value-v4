import S13Kernel.Data.Keys

/-! Keys number 35565 to 35654. `data/c/c00458.txt` has sha256 0ed43615b1039843461e6fb350ae13a939beb8ed69e3f7a3f1f8b97469e123b3. -/

namespace S13K.Chunks.C00458

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00458.txt"

theorem chk : chkChunk S N 35565 90 ces = true := by decide +kernel

theorem ok : RangeOK S N 35565 35655 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00458

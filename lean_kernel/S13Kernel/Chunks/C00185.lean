import S13Kernel.Data.Keys

/-! Keys number 12282 to 12346. `data/c/c00185.txt` has sha256 dcdfad09c108e3b58cae13a1fa3bf0f7ec5d21980544bd262328ff5dda82eb92. -/

namespace S13K.Chunks.C00185

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00185.txt"

theorem chk : chkChunk S N 12282 65 ces = true := by decide +kernel

theorem ok : RangeOK S N 12282 12347 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00185

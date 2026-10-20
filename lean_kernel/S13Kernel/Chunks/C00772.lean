import S13Kernel.Data.Keys

/-! Keys number 65109 to 65193. `data/c/c00772.txt` has sha256 1b683b39a07c2a76dde258a07ad366aedafb45fcbb2eb08a914b2d833423997f. -/

namespace S13K.Chunks.C00772

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00772.txt"

theorem chk : chkChunk S N 65109 85 ces = true := by decide +kernel

theorem ok : RangeOK S N 65109 65194 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00772

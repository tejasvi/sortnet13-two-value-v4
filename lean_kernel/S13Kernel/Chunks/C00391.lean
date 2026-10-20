import S13Kernel.Data.Keys

/-! Keys number 29904 to 29988. `data/c/c00391.txt` has sha256 7d1cc2df51ba5acd7fed31e0a6c0a2bec3ffbf382ce274cde89618e677d4d9a9. -/

namespace S13K.Chunks.C00391

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00391.txt"

theorem chk : chkChunk S N 29904 85 ces = true := by decide +kernel

theorem ok : RangeOK S N 29904 29989 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00391

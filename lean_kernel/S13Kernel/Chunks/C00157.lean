import S13Kernel.Data.Keys

/-! Keys number 10367 to 10452. `data/c/c00157.txt` has sha256 344487a545f879d9bbc1f4b0bb2ba90400317967ed707f7637a0d752a8bf4b3b. -/

namespace S13K.Chunks.C00157

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00157.txt"

theorem chk : chkChunk S N 10367 86 ces = true := by decide +kernel

theorem ok : RangeOK S N 10367 10453 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00157

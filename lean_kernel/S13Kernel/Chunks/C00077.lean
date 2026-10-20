import S13Kernel.Data.Keys

/-! Keys number 4491 to 4567. `data/c/c00077.txt` has sha256 e3998a7f7a72fbaab0ce08a418cc0367c2510470deb96a8d2dbcd7222d7ae3e8. -/

namespace S13K.Chunks.C00077

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00077.txt"

theorem chk : chkChunk S N 4491 77 ces = true := by decide +kernel

theorem ok : RangeOK S N 4491 4568 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00077

import S13Kernel.Data.Keys

/-! Keys number 16398 to 16467. `data/c/c00234.txt` has sha256 75d5cdaf3efcaa63ad82a2a17362b67515fb3273f4cb9cfd81210eada6e2beea. -/

namespace S13K.Chunks.C00234

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00234.txt"

theorem chk : chkChunk S N 16398 70 ces = true := by decide +kernel

theorem ok : RangeOK S N 16398 16468 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00234

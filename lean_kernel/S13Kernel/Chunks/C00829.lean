import S13Kernel.Data.Keys

/-! Keys number 70531 to 70619. `data/c/c00829.txt` has sha256 96de865dfdb4ddf5ed906eddbc4e04416602aee93730a09fdb2985a87cb55ef5. -/

namespace S13K.Chunks.C00829

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00829.txt"

theorem chk : chkChunk S N 70531 89 ces = true := by decide +kernel

theorem ok : RangeOK S N 70531 70620 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00829

import S13Kernel.Data.Keys

/-! Keys number 77897 to 78017. `data/c/c00902.txt` has sha256 c9d2a46a86a3931daebfe69e4ba9b53917a815942a2784d33714bac84a397e84. -/

namespace S13K.Chunks.C00902

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00902.txt"

theorem chk : chkChunk S N 77897 121 ces = true := by decide +kernel

theorem ok : RangeOK S N 77897 78018 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00902

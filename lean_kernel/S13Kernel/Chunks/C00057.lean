import S13Kernel.Data.Keys

/-! Keys number 3105 to 3182. `data/c/c00057.txt` has sha256 bab6aa5fcd147a140696427e8757dd8643d837f2dd105681d82c984aaf7d09d8. -/

namespace S13K.Chunks.C00057

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00057.txt"

theorem chk : chkChunk S N 3105 78 ces = true := by decide +kernel

theorem ok : RangeOK S N 3105 3183 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00057

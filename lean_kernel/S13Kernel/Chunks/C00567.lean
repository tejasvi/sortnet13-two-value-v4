import S13Kernel.Data.Keys

/-! Keys number 45745 to 45855. `data/c/c00567.txt` has sha256 8b0472243fa56b94489ec7c37203a64f7c20013301bb4730ead953dddac782ce. -/

namespace S13K.Chunks.C00567

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00567.txt"

theorem chk : chkChunk S N 45745 111 ces = true := by decide +kernel

theorem ok : RangeOK S N 45745 45856 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00567

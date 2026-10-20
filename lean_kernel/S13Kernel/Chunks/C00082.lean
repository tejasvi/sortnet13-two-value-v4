import S13Kernel.Data.Keys

/-! Keys number 4840 to 4904. `data/c/c00082.txt` has sha256 e23e2bd2d3ef81a5e85a7a8322fa0bec499e5c96b41e7d5b364ace01e0c5e5b2. -/

namespace S13K.Chunks.C00082

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00082.txt"

theorem chk : chkChunk S N 4840 65 ces = true := by decide +kernel

theorem ok : RangeOK S N 4840 4905 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00082

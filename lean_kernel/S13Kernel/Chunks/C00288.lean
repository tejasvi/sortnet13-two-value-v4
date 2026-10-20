import S13Kernel.Data.Keys

/-! Keys number 20837 to 20921. `data/c/c00288.txt` has sha256 d270c2e44d3b4c4aabdf45accbc5fc8b84824a630b0488db82fb7cb597a8a624. -/

namespace S13K.Chunks.C00288

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00288.txt"

theorem chk : chkChunk S N 20837 85 ces = true := by decide +kernel

theorem ok : RangeOK S N 20837 20922 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00288

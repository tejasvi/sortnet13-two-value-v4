import S13Kernel.Data.Keys

/-! Keys number 2954 to 3024. `data/c/c00055.txt` has sha256 118f538f9343093dee0fceeed92fab0e773b12944c8f8da58d7b1bf75b9efbe0. -/

namespace S13K.Chunks.C00055

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00055.txt"

theorem chk : chkChunk S N 2954 71 ces = true := by decide +kernel

theorem ok : RangeOK S N 2954 3025 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00055

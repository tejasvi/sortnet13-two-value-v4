import S13Kernel.Data.Keys

/-! Keys number 6232 to 6313. `data/c/c00104.txt` has sha256 78097e0539dbb0ea9790f4ea81540eb12a0bcaefbe8f22a2399d554fdc8c893c. -/

namespace S13K.Chunks.C00104

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00104.txt"

theorem chk : chkChunk S N 6232 82 ces = true := by decide +kernel

theorem ok : RangeOK S N 6232 6314 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00104

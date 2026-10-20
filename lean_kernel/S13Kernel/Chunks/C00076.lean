import S13Kernel.Data.Keys

/-! Keys number 4407 to 4490. `data/c/c00076.txt` has sha256 6e7a518f7261d81b65347958861a663cc1f24a58670253c8d64dd4fb0e25b2a2. -/

namespace S13K.Chunks.C00076

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00076.txt"

theorem chk : chkChunk S N 4407 84 ces = true := by decide +kernel

theorem ok : RangeOK S N 4407 4491 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00076

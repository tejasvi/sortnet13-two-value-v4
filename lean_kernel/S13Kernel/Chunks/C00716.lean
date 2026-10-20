import S13Kernel.Data.Keys

/-! Keys number 59468 to 59581. `data/c/c00716.txt` has sha256 e2aa0e4380da33e66d65463845171057c73aefc8a6233f94a49823250fdea18e. -/

namespace S13K.Chunks.C00716

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00716.txt"

theorem chk : chkChunk S N 59468 114 ces = true := by decide +kernel

theorem ok : RangeOK S N 59468 59582 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00716

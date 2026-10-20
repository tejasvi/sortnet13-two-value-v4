import S13Kernel.Data.Keys

/-! Keys number 17739 to 17822. `data/c/c00249.txt` has sha256 e2be3b6a0b2fa116f77a165a409b0d2bba59387be909f92a608a522d6670719c. -/

namespace S13K.Chunks.C00249

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00249.txt"

theorem chk : chkChunk S N 17739 84 ces = true := by decide +kernel

theorem ok : RangeOK S N 17739 17823 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00249

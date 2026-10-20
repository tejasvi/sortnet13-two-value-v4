import S13Kernel.Data.Keys

/-! Keys number 91148 to 91257. `data/c/c01028.txt` has sha256 23a1d1ed287bad15401c0dad0ce5c5a6b1fccff6bc2daec3c014d493144804ec. -/

namespace S13K.Chunks.C01028

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01028.txt"

theorem chk : chkChunk S N 91148 110 ces = true := by decide +kernel

theorem ok : RangeOK S N 91148 91258 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01028

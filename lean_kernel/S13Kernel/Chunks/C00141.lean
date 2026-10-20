import S13Kernel.Data.Keys

/-! Keys number 9089 to 9186. `data/c/c00141.txt` has sha256 718e49913084e2ac6fdc5d515738a30da9e77bd2cd6572db1d73c6ffb4b360e5. -/

namespace S13K.Chunks.C00141

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00141.txt"

theorem chk : chkChunk S N 9089 98 ces = true := by decide +kernel

theorem ok : RangeOK S N 9089 9187 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00141

import S13Kernel.Data.Keys

/-! Keys number 92025 to 92135. `data/c/c01036.txt` has sha256 c40dc28d4b87bfb3d3d1da10a27c1b4547e5b2071f195d21b5c981f9569dccb0. -/

namespace S13K.Chunks.C01036

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01036.txt"

theorem chk : chkChunk S N 92025 111 ces = true := by decide +kernel

theorem ok : RangeOK S N 92025 92136 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01036

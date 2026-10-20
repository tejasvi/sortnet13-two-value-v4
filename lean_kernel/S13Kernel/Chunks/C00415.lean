import S13Kernel.Data.Keys

/-! Keys number 32068 to 32158. `data/c/c00415.txt` has sha256 92c5463d184f244c9c0be0548bb369a8e7e9c16d2f71cf53265acc271b256b3d. -/

namespace S13K.Chunks.C00415

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00415.txt"

theorem chk : chkChunk S N 32068 91 ces = true := by decide +kernel

theorem ok : RangeOK S N 32068 32159 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00415

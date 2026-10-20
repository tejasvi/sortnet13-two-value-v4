import S13Kernel.Data.Keys

/-! Keys number 3025 to 3104. `data/c/c00056.txt` has sha256 b8410a1d37b6d591ec71f45afb3831b73ba1d8a60dae4214d7818168b154af50. -/

namespace S13K.Chunks.C00056

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00056.txt"

theorem chk : chkChunk S N 3025 80 ces = true := by decide +kernel

theorem ok : RangeOK S N 3025 3105 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00056

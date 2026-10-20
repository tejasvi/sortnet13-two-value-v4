import S13Kernel.Data.Keys

/-! Keys number 78596 to 78688. `data/c/c00909.txt` has sha256 f8bb762e2ca3fe097ef10bc7066965cf7e2d82b387a8c7c94b5936f09c72df2c. -/

namespace S13K.Chunks.C00909

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00909.txt"

theorem chk : chkChunk S N 78596 93 ces = true := by decide +kernel

theorem ok : RangeOK S N 78596 78689 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00909

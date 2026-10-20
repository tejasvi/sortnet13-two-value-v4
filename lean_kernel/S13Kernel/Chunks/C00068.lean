import S13Kernel.Data.Keys

/-! Keys number 3852 to 3913. `data/c/c00068.txt` has sha256 369f281dfeaa63e11b978bece97a79ec9725e78d6ea6a56233b2b22e6582723b. -/

namespace S13K.Chunks.C00068

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00068.txt"

theorem chk : chkChunk S N 3852 62 ces = true := by decide +kernel

theorem ok : RangeOK S N 3852 3914 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00068

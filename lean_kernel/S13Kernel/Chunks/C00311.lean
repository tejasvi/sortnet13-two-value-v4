import S13Kernel.Data.Keys

/-! Keys number 22621 to 22719. `data/c/c00311.txt` has sha256 b90b751e930a65a4a0bfaa40a90ada8d8c4ce3c2f1be33b4e543b7c831f7c59a. -/

namespace S13K.Chunks.C00311

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00311.txt"

theorem chk : chkChunk S N 22621 99 ces = true := by decide +kernel

theorem ok : RangeOK S N 22621 22720 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00311

import S13Kernel.Data.Keys

/-! Keys number 84384 to 84503. `data/c/c00965.txt` has sha256 dbf2fb6a25faa5d198afee5e56df0d52694b040c51e5a8572c74e06f8d579a3d. -/

namespace S13K.Chunks.C00965

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00965.txt"

theorem chk : chkChunk S N 84384 120 ces = true := by decide +kernel

theorem ok : RangeOK S N 84384 84504 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00965

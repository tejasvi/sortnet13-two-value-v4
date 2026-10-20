import S13Kernel.Data.Keys

/-! Keys number 46049 to 46137. `data/c/c00570.txt` has sha256 2c888855f898fce6c805f3a8530fc93cec9427b6023fadf4328f4e762419dcd6. -/

namespace S13K.Chunks.C00570

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00570.txt"

theorem chk : chkChunk S N 46049 89 ces = true := by decide +kernel

theorem ok : RangeOK S N 46049 46138 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00570

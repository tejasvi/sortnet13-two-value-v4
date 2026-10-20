import S13Kernel.Data.Keys

/-! Keys number 97518 to 97636. `data/c/c01084.txt` has sha256 eed03bb6c6b5eb3ad87a046dd7fe94fc0f3ce15ed0499a5f8c78a4081ff057f5. -/

namespace S13K.Chunks.C01084

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01084.txt"

theorem chk : chkChunk S N 97518 119 ces = true := by decide +kernel

theorem ok : RangeOK S N 97518 97637 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01084

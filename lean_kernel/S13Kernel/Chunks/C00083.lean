import S13Kernel.Data.Keys

/-! Keys number 4905 to 4976. `data/c/c00083.txt` has sha256 4c467718a34bd088c80fd4d5949b668b7c3402f91cc029f261376d368923d209. -/

namespace S13K.Chunks.C00083

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00083.txt"

theorem chk : chkChunk S N 4905 72 ces = true := by decide +kernel

theorem ok : RangeOK S N 4905 4977 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00083

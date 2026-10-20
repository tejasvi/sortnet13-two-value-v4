import S13Kernel.Data.Keys

/-! Keys number 11498 to 11579. `data/c/c00174.txt` has sha256 9e5bee53d664c439278d1dc5e34d35e67dc32fc279a1e697d2ac35b8068d8885. -/

namespace S13K.Chunks.C00174

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00174.txt"

theorem chk : chkChunk S N 11498 82 ces = true := by decide +kernel

theorem ok : RangeOK S N 11498 11580 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00174

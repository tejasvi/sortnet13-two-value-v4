import S13Kernel.Data.Keys

/-! Keys number 24279 to 24359. `data/c/c00328.txt` has sha256 896f4169f26f1316634155c246cc74d40b5aedce976c3736c639fd185123e24b. -/

namespace S13K.Chunks.C00328

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00328.txt"

theorem chk : chkChunk S N 24279 81 ces = true := by decide +kernel

theorem ok : RangeOK S N 24279 24360 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00328

import S13Kernel.Data.Keys

/-! Keys number 9850 to 9916. `data/c/c00150.txt` has sha256 f3a072d5ac32562ef27433d2029b090dfa54885d30bb5b49acd8865c52c4e04a. -/

namespace S13K.Chunks.C00150

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00150.txt"

theorem chk : chkChunk S N 9850 67 ces = true := by decide +kernel

theorem ok : RangeOK S N 9850 9917 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00150

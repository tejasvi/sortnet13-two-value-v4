import S13Kernel.Data.Keys

/-! Keys number 38864 to 38945. `data/c/c00493.txt` has sha256 bca5448d181b97cb174f90e1659959f8077772e97ecfa0dc68379b240a289cda. -/

namespace S13K.Chunks.C00493

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00493.txt"

theorem chk : chkChunk S N 38864 82 ces = true := by decide +kernel

theorem ok : RangeOK S N 38864 38946 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00493

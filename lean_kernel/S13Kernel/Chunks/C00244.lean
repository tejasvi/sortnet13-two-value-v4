import S13Kernel.Data.Keys

/-! Keys number 17295 to 17400. `data/c/c00244.txt` has sha256 8ebb325348dc44ea54cfd271bcb2ef18ff5d94585a978add113ad56badbdc368. -/

namespace S13K.Chunks.C00244

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00244.txt"

theorem chk : chkChunk S N 17295 106 ces = true := by decide +kernel

theorem ok : RangeOK S N 17295 17401 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00244

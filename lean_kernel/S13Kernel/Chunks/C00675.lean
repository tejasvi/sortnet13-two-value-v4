import S13Kernel.Data.Keys

/-! Keys number 55633 to 55729. `data/c/c00675.txt` has sha256 d5e80d505cd8022acc9cf17c2e619e885471b172cefe8c3784857a94ca91adce. -/

namespace S13K.Chunks.C00675

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00675.txt"

theorem chk : chkChunk S N 55633 97 ces = true := by decide +kernel

theorem ok : RangeOK S N 55633 55730 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00675

import S13Kernel.Data.Keys

/-! Keys number 41744 to 41827. `data/c/c00526.txt` has sha256 64e2ada0157413dbc3e85e1c98f7155c2f952c104e98f2b6b21fd5fd9b03caf5. -/

namespace S13K.Chunks.C00526

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00526.txt"

theorem chk : chkChunk S N 41744 84 ces = true := by decide +kernel

theorem ok : RangeOK S N 41744 41828 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00526

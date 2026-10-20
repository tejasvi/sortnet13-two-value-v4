import S13Kernel.Data.Keys

/-! Keys number 80269 to 80371. `data/c/c00925.txt` has sha256 e0eddc7598cfff9981e0da0746f7f828619f3e420c1521331a0e426b3dcd5507. -/

namespace S13K.Chunks.C00925

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00925.txt"

theorem chk : chkChunk S N 80269 103 ces = true := by decide +kernel

theorem ok : RangeOK S N 80269 80372 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00925

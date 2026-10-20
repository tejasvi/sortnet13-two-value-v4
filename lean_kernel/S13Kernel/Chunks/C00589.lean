import S13Kernel.Data.Keys

/-! Keys number 47769 to 47860. `data/c/c00589.txt` has sha256 d18d633f18ca1e9a164d93322c1b9be2628edb1906320c889d789db29e2d9f8f. -/

namespace S13K.Chunks.C00589

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00589.txt"

theorem chk : chkChunk S N 47769 92 ces = true := by decide +kernel

theorem ok : RangeOK S N 47769 47861 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00589

import S13Kernel.Data.Keys

/-! Keys number 81141 to 81229. `data/c/c00934.txt` has sha256 4078dffb1eed64a4ce2440c82ded3b8b328ed9ccda1acda86724b92f37616e35. -/

namespace S13K.Chunks.C00934

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00934.txt"

theorem chk : chkChunk S N 81141 89 ces = true := by decide +kernel

theorem ok : RangeOK S N 81141 81230 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00934

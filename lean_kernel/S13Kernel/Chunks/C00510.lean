import S13Kernel.Data.Keys

/-! Keys number 40309 to 40428. `data/c/c00510.txt` has sha256 a4898e4dcab2645fbbec7debacf4882cc9cf57d130084600c20ee5f99c18ecd3. -/

namespace S13K.Chunks.C00510

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00510.txt"

theorem chk : chkChunk S N 40309 120 ces = true := by decide +kernel

theorem ok : RangeOK S N 40309 40429 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00510

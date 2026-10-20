import S13Kernel.Data.Keys

/-! Keys number 21353 to 21427. `data/c/c00295.txt` has sha256 cdb541ee301f64f166258b305248c2aae87eebc6f106052407e5528bcf25daa8. -/

namespace S13K.Chunks.C00295

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00295.txt"

theorem chk : chkChunk S N 21353 75 ces = true := by decide +kernel

theorem ok : RangeOK S N 21353 21428 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00295

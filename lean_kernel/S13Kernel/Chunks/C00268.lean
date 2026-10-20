import S13Kernel.Data.Keys

/-! Keys number 19365 to 19454. `data/c/c00268.txt` has sha256 1a5a3c1327fb20f7e710aa530165576fc743a488c7c28fa50ac4f4912d5b1430. -/

namespace S13K.Chunks.C00268

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00268.txt"

theorem chk : chkChunk S N 19365 90 ces = true := by decide +kernel

theorem ok : RangeOK S N 19365 19455 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00268

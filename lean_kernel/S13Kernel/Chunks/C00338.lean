import S13Kernel.Data.Keys

/-! Keys number 25109 to 25214. `data/c/c00338.txt` has sha256 9e193fd7278bb82fb1394f0ea8ac6052a68e3f17de904dbc486c8952dee8900b. -/

namespace S13K.Chunks.C00338

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00338.txt"

theorem chk : chkChunk S N 25109 106 ces = true := by decide +kernel

theorem ok : RangeOK S N 25109 25215 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00338

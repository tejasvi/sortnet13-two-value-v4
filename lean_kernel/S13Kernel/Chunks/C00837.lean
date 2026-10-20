import S13Kernel.Data.Keys

/-! Keys number 71324 to 71443. `data/c/c00837.txt` has sha256 500fef1365bb0474be938241c974f37c454184ed1fe39e309eb3c2be3dffdc93. -/

namespace S13K.Chunks.C00837

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00837.txt"

theorem chk : chkChunk S N 71324 120 ces = true := by decide +kernel

theorem ok : RangeOK S N 71324 71444 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00837

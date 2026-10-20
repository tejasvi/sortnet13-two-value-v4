import S13Kernel.Data.Keys

/-! Keys number 329 to 367. `data/c/c00008.txt` has sha256 26f9be93234679d3dd7a977e59b69862851ce950c46688be89622e5c3b23361c. -/

namespace S13K.Chunks.C00008

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00008.txt"

theorem chk : chkChunk S N 329 39 ces = true := by decide +kernel

theorem ok : RangeOK S N 329 368 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00008

import S13Kernel.Data.Keys

/-! Keys number 2332 to 2376. `data/c/c00044.txt` has sha256 7a5748298ccbee6e0f1279d81596338728aaea9b89782b98dfc78f9552231075. -/

namespace S13K.Chunks.C00044

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00044.txt"

theorem chk : chkChunk S N 2332 45 ces = true := by decide +kernel

theorem ok : RangeOK S N 2332 2377 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00044

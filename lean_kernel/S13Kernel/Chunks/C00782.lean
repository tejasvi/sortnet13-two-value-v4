import S13Kernel.Data.Keys

/-! Keys number 65975 to 66054. `data/c/c00782.txt` has sha256 c28e6b2488992f7e8559b363994644af9690efaba117b5b7b3180d5ac1241c5b. -/

namespace S13K.Chunks.C00782

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00782.txt"

theorem chk : chkChunk S N 65975 80 ces = true := by decide +kernel

theorem ok : RangeOK S N 65975 66055 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00782

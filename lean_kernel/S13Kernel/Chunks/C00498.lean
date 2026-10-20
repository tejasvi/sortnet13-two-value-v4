import S13Kernel.Data.Keys

/-! Keys number 39274 to 39365. `data/c/c00498.txt` has sha256 9d847efca9d6a34790110ada148154b22c5eaa7dfd98111c452bbab03ab35bc8. -/

namespace S13K.Chunks.C00498

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00498.txt"

theorem chk : chkChunk S N 39274 92 ces = true := by decide +kernel

theorem ok : RangeOK S N 39274 39366 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00498

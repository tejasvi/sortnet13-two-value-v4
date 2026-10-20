import S13Kernel.Data.Keys

/-! Keys number 55110 to 55207. `data/c/c00669.txt` has sha256 15384aa5fc673dfed774b2ca2a6e55955381cbe4b7e477d2c6c4f89394072cc4. -/

namespace S13K.Chunks.C00669

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00669.txt"

theorem chk : chkChunk S N 55110 98 ces = true := by decide +kernel

theorem ok : RangeOK S N 55110 55208 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00669

import S13Kernel.Data.Keys

/-! Keys number 16241 to 16329. `data/c/c00232.txt` has sha256 5f9ad9e574e065014af4b9222ab06fd4fc097cb63dc5fb6d28198242ef1881d9. -/

namespace S13K.Chunks.C00232

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00232.txt"

theorem chk : chkChunk S N 16241 89 ces = true := by decide +kernel

theorem ok : RangeOK S N 16241 16330 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00232

import S13Kernel.Data.Keys

/-! Keys number 60245 to 60354. `data/c/c00723.txt` has sha256 3fe0dd06425b1976a10fc92b68add7a802bb5623434e0f7f42bd220387e45be5. -/

namespace S13K.Chunks.C00723

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00723.txt"

theorem chk : chkChunk S N 60245 110 ces = true := by decide +kernel

theorem ok : RangeOK S N 60245 60355 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00723

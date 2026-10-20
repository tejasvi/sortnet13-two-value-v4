import S13Kernel.Data.Keys

/-! Keys number 15109 to 15190. `data/c/c00219.txt` has sha256 cbc89e7ad68e03167e592576c8e200f44c63dd5f6a58df517af6b00bbb646b69. -/

namespace S13K.Chunks.C00219

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00219.txt"

theorem chk : chkChunk S N 15109 82 ces = true := by decide +kernel

theorem ok : RangeOK S N 15109 15191 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00219

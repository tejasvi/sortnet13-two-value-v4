import S13Kernel.Data.Keys

/-! Keys number 34964 to 35058. `data/c/c00451.txt` has sha256 eee672aca31162715d92ab1c5effdd6b6313326c62f5a4b567eb0722ead0da0a. -/

namespace S13K.Chunks.C00451

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00451.txt"

theorem chk : chkChunk S N 34964 95 ces = true := by decide +kernel

theorem ok : RangeOK S N 34964 35059 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00451

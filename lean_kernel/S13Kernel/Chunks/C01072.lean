import S13Kernel.Data.Keys

/-! Keys number 96094 to 96211. `data/c/c01072.txt` has sha256 2f4473d9a7e7908877c5e094639f7b072924a2d37e57e71bdd83cf16cefc86f3. -/

namespace S13K.Chunks.C01072

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01072.txt"

theorem chk : chkChunk S N 96094 118 ces = true := by decide +kernel

theorem ok : RangeOK S N 96094 96212 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01072

import S13Kernel.Data.Keys

/-! Keys number 91913 to 92024. `data/c/c01035.txt` has sha256 95c706c0d3bff3dd2820a8a824484e841c8f6c84349a9d3e4de91c6f89cccb6b. -/

namespace S13K.Chunks.C01035

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01035.txt"

theorem chk : chkChunk S N 91913 112 ces = true := by decide +kernel

theorem ok : RangeOK S N 91913 92025 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01035

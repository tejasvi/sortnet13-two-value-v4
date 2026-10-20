import S13Kernel.Data.Keys

/-! Keys number 96212 to 96331. `data/c/c01073.txt` has sha256 75149734e392235b5852602ad7b50b91c53075a5afa24873bca39c2924579cd8. -/

namespace S13K.Chunks.C01073

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01073.txt"

theorem chk : chkChunk S N 96212 120 ces = true := by decide +kernel

theorem ok : RangeOK S N 96212 96332 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01073

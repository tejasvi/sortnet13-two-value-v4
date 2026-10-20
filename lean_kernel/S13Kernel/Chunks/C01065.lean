import S13Kernel.Data.Keys

/-! Keys number 95276 to 95387. `data/c/c01065.txt` has sha256 d753133c4cba08ca673cd697a3704afded8049d5eb0c81a7f4658bdc915d1ecb. -/

namespace S13K.Chunks.C01065

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01065.txt"

theorem chk : chkChunk S N 95276 112 ces = true := by decide +kernel

theorem ok : RangeOK S N 95276 95388 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01065

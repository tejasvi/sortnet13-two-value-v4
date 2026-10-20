import S13Kernel.Data.Keys

/-! Keys number 89599 to 89711. `data/c/c01014.txt` has sha256 d955232752f15fee66f2f0fc16c743c5092c275c71beffabbb06a73974e218b8. -/

namespace S13K.Chunks.C01014

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01014.txt"

theorem chk : chkChunk S N 89599 113 ces = true := by decide +kernel

theorem ok : RangeOK S N 89599 89712 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01014

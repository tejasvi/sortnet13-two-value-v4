import S13Kernel.Data.Keys

/-! Keys number 47408 to 47498. `data/c/c00585.txt` has sha256 1e19514a1412bab1ca8cdf6f741b5aed8db7253b9e786f702bdc95689257ee4b. -/

namespace S13K.Chunks.C00585

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00585.txt"

theorem chk : chkChunk S N 47408 91 ces = true := by decide +kernel

theorem ok : RangeOK S N 47408 47499 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00585

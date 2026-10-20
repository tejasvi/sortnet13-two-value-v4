import S13Kernel.Data.Keys

/-! Keys number 74472 to 74570. `data/c/c00870.txt` has sha256 3f4b3ac3c05e75b1c168d59152729533816b39da381f50043ac24a20ce2710ee. -/

namespace S13K.Chunks.C00870

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00870.txt"

theorem chk : chkChunk S N 74472 99 ces = true := by decide +kernel

theorem ok : RangeOK S N 74472 74571 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00870

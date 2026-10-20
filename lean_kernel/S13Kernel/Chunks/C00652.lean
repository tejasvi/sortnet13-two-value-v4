import S13Kernel.Data.Keys

/-! Keys number 53436 to 53537. `data/c/c00652.txt` has sha256 c466e2adc195374f6b21eca06082732ff278b76e54389377fb7c92514160195a. -/

namespace S13K.Chunks.C00652

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00652.txt"

theorem chk : chkChunk S N 53436 102 ces = true := by decide +kernel

theorem ok : RangeOK S N 53436 53538 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00652

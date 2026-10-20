import S13Kernel.Data.Keys

/-! Keys number 97877 to 98000. `data/c/c01087.txt` has sha256 4b4b93a920ca4c728f4f3a4372cc3581721a85854058088d3bcd88678dcabf92. -/

namespace S13K.Chunks.C01087

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01087.txt"

theorem chk : chkChunk S N 97877 124 ces = true := by decide +kernel

theorem ok : RangeOK S N 97877 98001 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01087

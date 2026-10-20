import S13Kernel.Data.Keys

/-! Keys number 39034 to 39121. `data/c/c00495.txt` has sha256 4f042cfb116c2563b694a969ff2950e187c999ee1b9fe773cc6bb8d1667eca74. -/

namespace S13K.Chunks.C00495

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00495.txt"

theorem chk : chkChunk S N 39034 88 ces = true := by decide +kernel

theorem ok : RangeOK S N 39034 39122 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00495

import S13Kernel.Data.Keys

/-! Keys number 29063 to 29158. `data/c/c00382.txt` has sha256 c9600d47a2534b06976d45a7432e5becf80cf851a51b5daaa1c67b446655aaa4. -/

namespace S13K.Chunks.C00382

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00382.txt"

theorem chk : chkChunk S N 29063 96 ces = true := by decide +kernel

theorem ok : RangeOK S N 29063 29159 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00382

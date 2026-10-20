import S13Kernel.Data.Keys

/-! Keys number 59136 to 59253. `data/c/c00713.txt` has sha256 343bd3cd7e828a0f0a661e9be5181eed3475162a8b5581cc9284d8c494db1d47. -/

namespace S13K.Chunks.C00713

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00713.txt"

theorem chk : chkChunk S N 59136 118 ces = true := by decide +kernel

theorem ok : RangeOK S N 59136 59254 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00713

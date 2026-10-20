import S13Kernel.Data.Keys

/-! Keys number 8157 to 8246. `data/c/c00129.txt` has sha256 bf8708d6d062f02b79ef1e6664c363e75f4cf60dd5df96110109c4dcd9645fab. -/

namespace S13K.Chunks.C00129

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00129.txt"

theorem chk : chkChunk S N 8157 90 ces = true := by decide +kernel

theorem ok : RangeOK S N 8157 8247 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00129

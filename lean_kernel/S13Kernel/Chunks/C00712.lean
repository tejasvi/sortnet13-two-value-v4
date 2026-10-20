import S13Kernel.Data.Keys

/-! Keys number 59026 to 59135. `data/c/c00712.txt` has sha256 0ffd69452ae3b3493db078297a19fb4c05eea7787138be3cf42483b74dd44c06. -/

namespace S13K.Chunks.C00712

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00712.txt"

theorem chk : chkChunk S N 59026 110 ces = true := by decide +kernel

theorem ok : RangeOK S N 59026 59136 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00712

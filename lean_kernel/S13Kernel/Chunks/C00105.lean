import S13Kernel.Data.Keys

/-! Keys number 6314 to 6391. `data/c/c00105.txt` has sha256 36d02f815db77de0e43eb376ae82ed1726842ba80b3f6a615287638c8e08a606. -/

namespace S13K.Chunks.C00105

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00105.txt"

theorem chk : chkChunk S N 6314 78 ces = true := by decide +kernel

theorem ok : RangeOK S N 6314 6392 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00105

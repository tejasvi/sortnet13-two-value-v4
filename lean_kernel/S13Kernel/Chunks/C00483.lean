import S13Kernel.Data.Keys

/-! Keys number 37853 to 37963. `data/c/c00483.txt` has sha256 376e08d5ee3a41af23045d7eae3a2a99e5f213e18032da1454b7cf9dec7f28b4. -/

namespace S13K.Chunks.C00483

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00483.txt"

theorem chk : chkChunk S N 37853 111 ces = true := by decide +kernel

theorem ok : RangeOK S N 37853 37964 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00483

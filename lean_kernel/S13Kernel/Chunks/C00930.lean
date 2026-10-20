import S13Kernel.Data.Keys

/-! Keys number 80750 to 80847. `data/c/c00930.txt` has sha256 2344a5d1205fbe8194183fc1d2f1c0115ee698f1485e7145a0c925a99eca00b3. -/

namespace S13K.Chunks.C00930

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00930.txt"

theorem chk : chkChunk S N 80750 98 ces = true := by decide +kernel

theorem ok : RangeOK S N 80750 80848 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00930

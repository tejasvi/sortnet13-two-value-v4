import S13Kernel.Data.Keys

/-! Keys number 74768 to 74868. `data/c/c00873.txt` has sha256 eb4a6025f043f614da2c7c9a5f14231fe58b66e608c1f2803e7f5f56f6347db2. -/

namespace S13K.Chunks.C00873

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00873.txt"

theorem chk : chkChunk S N 74768 101 ces = true := by decide +kernel

theorem ok : RangeOK S N 74768 74869 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00873

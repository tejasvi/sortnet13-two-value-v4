import S13Kernel.Data.Keys

/-! Keys number 2270 to 2331. `data/c/c00043.txt` has sha256 f5e9d3f4614e621d725625211f3aa6389bf407e186d2e0eadc5edf302c30f800. -/

namespace S13K.Chunks.C00043

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00043.txt"

theorem chk : chkChunk S N 2270 62 ces = true := by decide +kernel

theorem ok : RangeOK S N 2270 2332 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00043

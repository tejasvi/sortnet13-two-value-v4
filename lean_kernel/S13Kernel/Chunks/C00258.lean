import S13Kernel.Data.Keys

/-! Keys number 18522 to 18601. `data/c/c00258.txt` has sha256 e73d3f514d0250f79a1695013829a788b85e481662a3d0b5c5ac456119382cf6. -/

namespace S13K.Chunks.C00258

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00258.txt"

theorem chk : chkChunk S N 18522 80 ces = true := by decide +kernel

theorem ok : RangeOK S N 18522 18602 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00258

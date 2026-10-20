import S13Kernel.Data.Keys

/-! Keys number 92897 to 93013. `data/c/c01044.txt` has sha256 f20dcfa38bfefc8bb313635ce64aefa6927b5c9e24981bdfdb368fc8704796ad. -/

namespace S13K.Chunks.C01044

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01044.txt"

theorem chk : chkChunk S N 92897 117 ces = true := by decide +kernel

theorem ok : RangeOK S N 92897 93014 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01044

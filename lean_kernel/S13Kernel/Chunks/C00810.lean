import S13Kernel.Data.Keys

/-! Keys number 68581 to 68682. `data/c/c00810.txt` has sha256 0bd908f0d066c2ed42ad96bda018cb52bb0896eafa1447811b11123c21d4ad7b. -/

namespace S13K.Chunks.C00810

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00810.txt"

theorem chk : chkChunk S N 68581 102 ces = true := by decide +kernel

theorem ok : RangeOK S N 68581 68683 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00810

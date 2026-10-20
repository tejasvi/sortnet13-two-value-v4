import S13Kernel.Data.Keys

/-! Keys number 41828 to 41924. `data/c/c00527.txt` has sha256 1e414028071ff7211ef311e67aeaa77b3cee3a918efaf4e4977626363a2495db. -/

namespace S13K.Chunks.C00527

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00527.txt"

theorem chk : chkChunk S N 41828 97 ces = true := by decide +kernel

theorem ok : RangeOK S N 41828 41925 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00527

import S13Kernel.Data.Keys

/-! Keys number 85541 to 85635. `data/c/c00976.txt` has sha256 6289fa10a6fe15fa08d8e402fdd76a1a335164fc6b84c160c4ff8d9fbefa8c95. -/

namespace S13K.Chunks.C00976

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00976.txt"

theorem chk : chkChunk S N 85541 95 ces = true := by decide +kernel

theorem ok : RangeOK S N 85541 85636 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00976

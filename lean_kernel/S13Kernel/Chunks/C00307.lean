import S13Kernel.Data.Keys

/-! Keys number 22327 to 22405. `data/c/c00307.txt` has sha256 a999717cbba4b9b671652a27911f78a96ea770946a729c3f0b725e40000c4926. -/

namespace S13K.Chunks.C00307

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00307.txt"

theorem chk : chkChunk S N 22327 79 ces = true := by decide +kernel

theorem ok : RangeOK S N 22327 22406 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00307

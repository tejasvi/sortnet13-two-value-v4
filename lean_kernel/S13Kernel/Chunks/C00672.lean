import S13Kernel.Data.Keys

/-! Keys number 55377 to 55465. `data/c/c00672.txt` has sha256 7426390496977b753d707b9574f2ba21327a289c8e931c189574e9b44c1ab2a5. -/

namespace S13K.Chunks.C00672

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00672.txt"

theorem chk : chkChunk S N 55377 89 ces = true := by decide +kernel

theorem ok : RangeOK S N 55377 55466 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00672

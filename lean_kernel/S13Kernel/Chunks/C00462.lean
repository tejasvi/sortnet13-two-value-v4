import S13Kernel.Data.Keys

/-! Keys number 35940 to 36036. `data/c/c00462.txt` has sha256 3939ed89e2235dcec75ca13c83142fe943d43a1f98869b23b4b7ea3684ad38ed. -/

namespace S13K.Chunks.C00462

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00462.txt"

theorem chk : chkChunk S N 35940 97 ces = true := by decide +kernel

theorem ok : RangeOK S N 35940 36037 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00462

import S13Kernel.Data.Keys

/-! Keys number 10213 to 10297. `data/c/c00155.txt` has sha256 1c2b4ded66bc138f74813261d2ef24e3a8d3313e6242c3739b0dacc0b2a92f35. -/

namespace S13K.Chunks.C00155

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00155.txt"

theorem chk : chkChunk S N 10213 85 ces = true := by decide +kernel

theorem ok : RangeOK S N 10213 10298 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00155

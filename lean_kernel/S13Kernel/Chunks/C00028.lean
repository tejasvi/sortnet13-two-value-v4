import S13Kernel.Data.Keys

/-! Keys number 1369 to 1422. `data/c/c00028.txt` has sha256 095339851cbba94a1ef3905f4c225927c7958a15a927280cf080c4efacb36b02. -/

namespace S13K.Chunks.C00028

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00028.txt"

theorem chk : chkChunk S N 1369 54 ces = true := by decide +kernel

theorem ok : RangeOK S N 1369 1423 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00028

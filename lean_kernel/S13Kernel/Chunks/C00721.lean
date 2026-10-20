import S13Kernel.Data.Keys

/-! Keys number 60014 to 60135. `data/c/c00721.txt` has sha256 99ead78230e90f08c29556a495f82e1f70615872e2d51e3860f2f0fa0776cd8d. -/

namespace S13K.Chunks.C00721

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00721.txt"

theorem chk : chkChunk S N 60014 122 ces = true := by decide +kernel

theorem ok : RangeOK S N 60014 60136 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00721

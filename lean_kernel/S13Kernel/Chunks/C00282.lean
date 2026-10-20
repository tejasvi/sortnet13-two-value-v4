import S13Kernel.Data.Keys

/-! Keys number 20425 to 20505. `data/c/c00282.txt` has sha256 b910ac0fcfc1959040c6189573886d9033bd9b4f8fef5718bd0b52e12ae2430d. -/

namespace S13K.Chunks.C00282

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00282.txt"

theorem chk : chkChunk S N 20425 81 ces = true := by decide +kernel

theorem ok : RangeOK S N 20425 20506 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00282

import S13Kernel.Data.Keys

/-! Keys number 45341 to 45440. `data/c/c00563.txt` has sha256 c69acd0cd832dd2ae312958429dd0560bdd248a2a3bd3004ba8e04404efe7e7d. -/

namespace S13K.Chunks.C00563

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00563.txt"

theorem chk : chkChunk S N 45341 100 ces = true := by decide +kernel

theorem ok : RangeOK S N 45341 45441 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00563

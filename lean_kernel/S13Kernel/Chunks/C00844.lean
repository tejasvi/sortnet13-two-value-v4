import S13Kernel.Data.Keys

/-! Keys number 72014 to 72112. `data/c/c00844.txt` has sha256 18f23d4ba5e50b267d2cf821a31351ea543ce6435082c96272b2b98f4c4bcb9b. -/

namespace S13K.Chunks.C00844

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00844.txt"

theorem chk : chkChunk S N 72014 99 ces = true := by decide +kernel

theorem ok : RangeOK S N 72014 72113 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00844

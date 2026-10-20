import S13Kernel.Data.Keys

/-! Keys number 52553 to 52644. `data/c/c00643.txt` has sha256 d425c3e788a4eb70cd51927e6c064e700c98a4d695d68ca49d580faceba1fbf4. -/

namespace S13K.Chunks.C00643

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00643.txt"

theorem chk : chkChunk S N 52553 92 ces = true := by decide +kernel

theorem ok : RangeOK S N 52553 52645 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00643

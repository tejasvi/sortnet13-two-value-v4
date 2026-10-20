import S13Kernel.Data.Keys

/-! Keys number 88717 to 88820. `data/c/c01006.txt` has sha256 6aa55d38016ceaecca5632c71c47cda657daf0f72a373df9b007de2c8859f595. -/

namespace S13K.Chunks.C01006

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01006.txt"

theorem chk : chkChunk S N 88717 104 ces = true := by decide +kernel

theorem ok : RangeOK S N 88717 88821 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01006

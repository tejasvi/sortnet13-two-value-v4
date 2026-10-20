import S13Kernel.Data.Keys

/-! Keys number 20576 to 20649. `data/c/c00284.txt` has sha256 02f422b50d1f6a1b2f5af992d0733662ed9c71817a4d5d934c2e1ba813a95395. -/

namespace S13K.Chunks.C00284

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00284.txt"

theorem chk : chkChunk S N 20576 74 ces = true := by decide +kernel

theorem ok : RangeOK S N 20576 20650 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00284

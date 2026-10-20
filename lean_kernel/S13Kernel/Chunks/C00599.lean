import S13Kernel.Data.Keys

/-! Keys number 48716 to 48800. `data/c/c00599.txt` has sha256 59a86201abf10dc252827a995813a55febfa41c963a57fb22b7720b38edbceec. -/

namespace S13K.Chunks.C00599

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00599.txt"

theorem chk : chkChunk S N 48716 85 ces = true := by decide +kernel

theorem ok : RangeOK S N 48716 48801 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00599

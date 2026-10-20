import S13Kernel.Data.Keys

/-! Keys number 64671 to 64778. `data/c/c00768.txt` has sha256 9b6c6695dfe8da3432ccf9895c212880fa8d00b94f4497af0836cabff8317464. -/

namespace S13K.Chunks.C00768

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00768.txt"

theorem chk : chkChunk S N 64671 108 ces = true := by decide +kernel

theorem ok : RangeOK S N 64671 64779 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00768

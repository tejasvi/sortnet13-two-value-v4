import S13Kernel.Data.Keys

/-! Keys number 7613 to 7671. `data/c/c00122.txt` has sha256 8e33c5f86207956a0a19bcc66af6aa041652807330af938832e1a03d57c80847. -/

namespace S13K.Chunks.C00122

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00122.txt"

theorem chk : chkChunk S N 7613 59 ces = true := by decide +kernel

theorem ok : RangeOK S N 7613 7672 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00122

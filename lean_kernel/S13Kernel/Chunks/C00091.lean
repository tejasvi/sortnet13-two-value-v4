import S13Kernel.Data.Keys

/-! Keys number 5415 to 5458. `data/c/c00091.txt` has sha256 08d797c7306a29efad0e28183e63fd8774313debeb11b3c128ecedef89d8630d. -/

namespace S13K.Chunks.C00091

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00091.txt"

theorem chk : chkChunk S N 5415 44 ces = true := by decide +kernel

theorem ok : RangeOK S N 5415 5459 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00091

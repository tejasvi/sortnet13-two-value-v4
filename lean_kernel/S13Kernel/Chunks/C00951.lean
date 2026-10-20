import S13Kernel.Data.Keys

/-! Keys number 82834 to 82939. `data/c/c00951.txt` has sha256 72be3fdb60e5355dad0011b0f900ec129e3a3d2df70b550efbb6fe6dff95157d. -/

namespace S13K.Chunks.C00951

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00951.txt"

theorem chk : chkChunk S N 82834 106 ces = true := by decide +kernel

theorem ok : RangeOK S N 82834 82940 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00951

import S13Kernel.Data.Keys

/-! Keys number 98605 to 98728. `data/c/c01093.txt` has sha256 dee1332ed93d0fd75b726775da443416581bcb03f53e5de46bb5bd09c2419d72. -/

namespace S13K.Chunks.C01093

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01093.txt"

theorem chk : chkChunk S N 98605 124 ces = true := by decide +kernel

theorem ok : RangeOK S N 98605 98729 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01093

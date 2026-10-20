import S13Kernel.Data.Keys

/-! Keys number 33250 to 33329. `data/c/c00429.txt` has sha256 624fce55884afa1c6773dec338afebcb71441118d1cb5a1ccb8651515ec29c08. -/

namespace S13K.Chunks.C00429

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00429.txt"

theorem chk : chkChunk S N 33250 80 ces = true := by decide +kernel

theorem ok : RangeOK S N 33250 33330 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00429

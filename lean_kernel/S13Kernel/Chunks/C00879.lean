import S13Kernel.Data.Keys

/-! Keys number 75414 to 75516. `data/c/c00879.txt` has sha256 742188769a2b20212ad608ab6c1bb75082cb3b95869a4a69cceb5d974d9e0c8d. -/

namespace S13K.Chunks.C00879

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00879.txt"

theorem chk : chkChunk S N 75414 103 ces = true := by decide +kernel

theorem ok : RangeOK S N 75414 75517 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00879

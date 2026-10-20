import S13Kernel.Data.Keys

/-! Keys number 53883 to 53962. `data/c/c00657.txt` has sha256 7d164827e95e9d68893b5a19407a5f732d2ae1b5ad622bdfec2ea425a02e6a16. -/

namespace S13K.Chunks.C00657

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00657.txt"

theorem chk : chkChunk S N 53883 80 ces = true := by decide +kernel

theorem ok : RangeOK S N 53883 53963 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00657

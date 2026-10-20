import S13Kernel.Data.Keys

/-! Keys number 71214 to 71323. `data/c/c00836.txt` has sha256 2a5940fbd621f1039faad96bcb6719c1f115163d84fb5ac1b7f225b2533f38f3. -/

namespace S13K.Chunks.C00836

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00836.txt"

theorem chk : chkChunk S N 71214 110 ces = true := by decide +kernel

theorem ok : RangeOK S N 71214 71324 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00836

import S13Kernel.Data.Keys

/-! Keys number 96332 to 96452. `data/c/c01074.txt` has sha256 e17e8d98550da15aa7ae8abc31aa98a0bc063601ab5635d202c874ba34a5434d. -/

namespace S13K.Chunks.C01074

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01074.txt"

theorem chk : chkChunk S N 96332 121 ces = true := by decide +kernel

theorem ok : RangeOK S N 96332 96453 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01074

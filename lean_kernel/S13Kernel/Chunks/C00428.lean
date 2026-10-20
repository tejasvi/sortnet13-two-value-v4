import S13Kernel.Data.Keys

/-! Keys number 33161 to 33249. `data/c/c00428.txt` has sha256 e81af9b121d0e1b90be9def14b2a65aab5bb9e806e3bccdaa1e1bc62be6256d5. -/

namespace S13K.Chunks.C00428

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00428.txt"

theorem chk : chkChunk S N 33161 89 ces = true := by decide +kernel

theorem ok : RangeOK S N 33161 33250 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00428

import S13Kernel.Data.Keys

/-! Keys number 4568 to 4631. `data/c/c00078.txt` has sha256 89780effec939ba3a559b6fdaaf5b6e093e625dcfdca830ea731e40fb269ef84. -/

namespace S13K.Chunks.C00078

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00078.txt"

theorem chk : chkChunk S N 4568 64 ces = true := by decide +kernel

theorem ok : RangeOK S N 4568 4632 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00078

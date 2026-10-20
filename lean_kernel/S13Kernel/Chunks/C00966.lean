import S13Kernel.Data.Keys

/-! Keys number 84504 to 84601. `data/c/c00966.txt` has sha256 b414477c2c489596a1a528ef60477bbf0174359694bdbe114d25c000c65731d6. -/

namespace S13K.Chunks.C00966

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00966.txt"

theorem chk : chkChunk S N 84504 98 ces = true := by decide +kernel

theorem ok : RangeOK S N 84504 84602 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00966

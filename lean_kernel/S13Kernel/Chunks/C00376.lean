import S13Kernel.Data.Keys

/-! Keys number 28509 to 28592. `data/c/c00376.txt` has sha256 c221346557a0ed675ca74e32167745f4751e47c6f5d440647b33ce4fb44f9596. -/

namespace S13K.Chunks.C00376

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00376.txt"

theorem chk : chkChunk S N 28509 84 ces = true := by decide +kernel

theorem ok : RangeOK S N 28509 28593 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00376

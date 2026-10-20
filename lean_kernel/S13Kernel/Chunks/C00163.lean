import S13Kernel.Data.Keys

/-! Keys number 10812 to 10869. `data/c/c00163.txt` has sha256 1015bc886eb1062030eb2d830499b28bb70189c7b7053c92a77d88477de5a8f7. -/

namespace S13K.Chunks.C00163

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00163.txt"

theorem chk : chkChunk S N 10812 58 ces = true := by decide +kernel

theorem ok : RangeOK S N 10812 10870 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00163

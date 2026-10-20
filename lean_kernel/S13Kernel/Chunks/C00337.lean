import S13Kernel.Data.Keys

/-! Keys number 25009 to 25108. `data/c/c00337.txt` has sha256 1335bb516b25587f77fb11da9390abd9685c57f9cf6c6eb5d65c82a86d14ea77. -/

namespace S13K.Chunks.C00337

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00337.txt"

theorem chk : chkChunk S N 25009 100 ces = true := by decide +kernel

theorem ok : RangeOK S N 25009 25109 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00337

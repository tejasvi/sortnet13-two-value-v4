import S13Kernel.Data.Keys

/-! Keys number 42788 to 42882. `data/c/c00537.txt` has sha256 8b52039c32682f5ec343dfa05b90a0c6c46be9d4d5b64f226c1bbb4e137d8d53. -/

namespace S13K.Chunks.C00537

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00537.txt"

theorem chk : chkChunk S N 42788 95 ces = true := by decide +kernel

theorem ok : RangeOK S N 42788 42883 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00537

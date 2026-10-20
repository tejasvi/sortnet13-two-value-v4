import S13Kernel.Data.Keys

/-! Keys number 64564 to 64670. `data/c/c00767.txt` has sha256 ced6cc962c7f4207e0fd0a6947cf1e4c376a64b10dfe488d30b4be28b71265e4. -/

namespace S13K.Chunks.C00767

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00767.txt"

theorem chk : chkChunk S N 64564 107 ces = true := by decide +kernel

theorem ok : RangeOK S N 64564 64671 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00767

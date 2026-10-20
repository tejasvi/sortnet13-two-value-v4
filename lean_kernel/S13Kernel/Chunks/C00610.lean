import S13Kernel.Data.Keys

/-! Keys number 49630 to 49706. `data/c/c00610.txt` has sha256 8d9ca586337efdcf98e0ff5a957f5fa9c02cf6830d40b36fe44030987c95d206. -/

namespace S13K.Chunks.C00610

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00610.txt"

theorem chk : chkChunk S N 49630 77 ces = true := by decide +kernel

theorem ok : RangeOK S N 49630 49707 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00610

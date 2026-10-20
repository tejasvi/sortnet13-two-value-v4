import S13Kernel.Data.Keys

/-! Keys number 55730 to 55825. `data/c/c00676.txt` has sha256 f4217c553a17eddf7b4914a29819a37e082ca71b77b56e81e87c7c7f59b5636d. -/

namespace S13K.Chunks.C00676

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00676.txt"

theorem chk : chkChunk S N 55730 96 ces = true := by decide +kernel

theorem ok : RangeOK S N 55730 55826 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00676

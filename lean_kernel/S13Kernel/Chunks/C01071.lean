import S13Kernel.Data.Keys

/-! Keys number 95977 to 96093. `data/c/c01071.txt` has sha256 5fa09c913b6d6e7ac9274fa1c2e8d43adbb4d3068e9a837d4d6247990cc0e56d. -/

namespace S13K.Chunks.C01071

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01071.txt"

theorem chk : chkChunk S N 95977 117 ces = true := by decide +kernel

theorem ok : RangeOK S N 95977 96094 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01071

import S13Kernel.Data.Keys

/-! Keys number 81823 to 81923. `data/c/c00941.txt` has sha256 4c07d7aff4d40001f5bf22589ea6be6e479b38f126036338a9dfb35f30cce727. -/

namespace S13K.Chunks.C00941

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00941.txt"

theorem chk : chkChunk S N 81823 101 ces = true := by decide +kernel

theorem ok : RangeOK S N 81823 81924 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00941

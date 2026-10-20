import S13Kernel.Data.Keys

/-! Keys number 15438 to 15524. `data/c/c00223.txt` has sha256 5904370de9e03229e699b03c3629d24fa7a674cafcba50ea93c31d50db2aa955. -/

namespace S13K.Chunks.C00223

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00223.txt"

theorem chk : chkChunk S N 15438 87 ces = true := by decide +kernel

theorem ok : RangeOK S N 15438 15525 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00223

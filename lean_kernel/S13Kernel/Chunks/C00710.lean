import S13Kernel.Data.Keys

/-! Keys number 58826 to 58927. `data/c/c00710.txt` has sha256 124975cfa84be2998980c02d9297001c59deb5a01c7ff893db5cac68640e0f18. -/

namespace S13K.Chunks.C00710

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00710.txt"

theorem chk : chkChunk S N 58826 102 ces = true := by decide +kernel

theorem ok : RangeOK S N 58826 58928 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00710

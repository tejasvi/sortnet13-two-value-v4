import S13Kernel.Data.Keys

/-! Keys number 68683 to 68784. `data/c/c00811.txt` has sha256 bb3da793ca675ed3d27e5f0e0878a14480aeed9714510e0a7ae69f87d6aeda28. -/

namespace S13K.Chunks.C00811

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00811.txt"

theorem chk : chkChunk S N 68683 102 ces = true := by decide +kernel

theorem ok : RangeOK S N 68683 68785 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00811

import S13Kernel.Data.Keys

/-! Keys number 77024 to 77128. `data/c/c00894.txt` has sha256 8ca0cc82bcbcb11de48a1862d0f612372bdfe9f8963ec6ba6d541a29cc061141. -/

namespace S13K.Chunks.C00894

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00894.txt"

theorem chk : chkChunk S N 77024 105 ces = true := by decide +kernel

theorem ok : RangeOK S N 77024 77129 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00894

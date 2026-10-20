import S13Kernel.Data.Keys

/-! Keys number 18083 to 18177. `data/c/c00253.txt` has sha256 987196fef41529935db581e337c39f3fc3d25e484e57a3df782ca312a908322a. -/

namespace S13K.Chunks.C00253

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00253.txt"

theorem chk : chkChunk S N 18083 95 ces = true := by decide +kernel

theorem ok : RangeOK S N 18083 18178 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00253

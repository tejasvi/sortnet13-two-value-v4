import S13Kernel.Data.Keys

/-! Keys number 34875 to 34963. `data/c/c00450.txt` has sha256 77009a651146c0d2630fa3cf60f597ea347bb53751c5fe3442e7a0169d201f32. -/

namespace S13K.Chunks.C00450

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00450.txt"

theorem chk : chkChunk S N 34875 89 ces = true := by decide +kernel

theorem ok : RangeOK S N 34875 34964 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00450

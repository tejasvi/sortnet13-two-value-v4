import S13Kernel.Data.Keys

/-! Keys number 87566 to 87675. `data/c/c00996.txt` has sha256 40677a2688e82e04a3d4dcdf2963e94a6158dddd45e8c0c1ee775cbfc0e3f010. -/

namespace S13K.Chunks.C00996

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00996.txt"

theorem chk : chkChunk S N 87566 110 ces = true := by decide +kernel

theorem ok : RangeOK S N 87566 87676 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00996

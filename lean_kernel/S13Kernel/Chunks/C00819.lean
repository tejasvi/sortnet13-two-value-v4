import S13Kernel.Data.Keys

/-! Keys number 69514 to 69623. `data/c/c00819.txt` has sha256 b992663cc6c3714e0b74b1d82a426427a56dd8fd13a6879683a103fcd29266aa. -/

namespace S13K.Chunks.C00819

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00819.txt"

theorem chk : chkChunk S N 69514 110 ces = true := by decide +kernel

theorem ok : RangeOK S N 69514 69624 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00819

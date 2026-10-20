import S13Kernel.Data.Keys

/-! Keys number 72651 to 72736. `data/c/c00851.txt` has sha256 ebd9fc1160e29f47013fd70b6dfbf141ef3e4d8de67ac48214d5df513284b1a7. -/

namespace S13K.Chunks.C00851

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00851.txt"

theorem chk : chkChunk S N 72651 86 ces = true := by decide +kernel

theorem ok : RangeOK S N 72651 72737 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00851

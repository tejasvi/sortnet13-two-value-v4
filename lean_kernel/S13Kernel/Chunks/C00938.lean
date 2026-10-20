import S13Kernel.Data.Keys

/-! Keys number 81518 to 81613. `data/c/c00938.txt` has sha256 ea2dbc63321259a09351f22848c2b4a9b225d9f1d6016f725cf11440fe3245dd. -/

namespace S13K.Chunks.C00938

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00938.txt"

theorem chk : chkChunk S N 81518 96 ces = true := by decide +kernel

theorem ok : RangeOK S N 81518 81614 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00938

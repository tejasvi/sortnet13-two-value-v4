import S13Kernel.Data.Keys

/-! Keys number 54259 to 54350. `data/c/c00661.txt` has sha256 30e2f8b3912170b1aed7055ada95163ffb365e2c1c36819b2791ae9d843410ca. -/

namespace S13K.Chunks.C00661

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00661.txt"

theorem chk : chkChunk S N 54259 92 ces = true := by decide +kernel

theorem ok : RangeOK S N 54259 54351 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00661

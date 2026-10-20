import S13Kernel.Data.Keys

/-! Keys number 80037 to 80147. `data/c/c00923.txt` has sha256 e8650f1c2c443813e5dc0c34f789e3d49647cf211d2df37423f999dddfefa869. -/

namespace S13K.Chunks.C00923

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00923.txt"

theorem chk : chkChunk S N 80037 111 ces = true := by decide +kernel

theorem ok : RangeOK S N 80037 80148 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00923

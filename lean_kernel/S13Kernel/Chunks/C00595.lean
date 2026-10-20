import S13Kernel.Data.Keys

/-! Keys number 48373 to 48468. `data/c/c00595.txt` has sha256 dbb638f60ddc9b92ea31087bc78a9cbe46d286da4370b25b925617a2d11973cb. -/

namespace S13K.Chunks.C00595

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00595.txt"

theorem chk : chkChunk S N 48373 96 ces = true := by decide +kernel

theorem ok : RangeOK S N 48373 48469 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00595

import S13Kernel.Data.Keys

/-! Keys number 29815 to 29903. `data/c/c00390.txt` has sha256 39055af4cfb88e235e7585ef318668215b41c2c72a15846a5509c7b117fd5ef6. -/

namespace S13K.Chunks.C00390

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00390.txt"

theorem chk : chkChunk S N 29815 89 ces = true := by decide +kernel

theorem ok : RangeOK S N 29815 29904 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00390

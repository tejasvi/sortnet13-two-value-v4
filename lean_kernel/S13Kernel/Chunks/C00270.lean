import S13Kernel.Data.Keys

/-! Keys number 19540 to 19623. `data/c/c00270.txt` has sha256 94dace647907a488de9c503850c6ef2336b80bfc902a651b1cdede6f9bf01980. -/

namespace S13K.Chunks.C00270

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00270.txt"

theorem chk : chkChunk S N 19540 84 ces = true := by decide +kernel

theorem ok : RangeOK S N 19540 19624 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00270

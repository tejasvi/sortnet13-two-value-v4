import S13Kernel.Data.Keys

/-! Keys number 50462 to 50540. `data/c/c00620.txt` has sha256 242e3d5fdaa37d0b71877df0309efc83119286d05b76247383dda5459cbc0533. -/

namespace S13K.Chunks.C00620

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00620.txt"

theorem chk : chkChunk S N 50462 79 ces = true := by decide +kernel

theorem ok : RangeOK S N 50462 50541 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00620

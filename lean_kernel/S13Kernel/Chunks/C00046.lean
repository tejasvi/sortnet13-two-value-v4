import S13Kernel.Data.Keys

/-! Keys number 2419 to 2472. `data/c/c00046.txt` has sha256 232a6315b60f254509a1f0bcc3512aa27466249b461cac781ac1997fa08a2be8. -/

namespace S13K.Chunks.C00046

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00046.txt"

theorem chk : chkChunk S N 2419 54 ces = true := by decide +kernel

theorem ok : RangeOK S N 2419 2473 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00046

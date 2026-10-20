import S13Kernel.Data.Keys

/-! Keys number 56508 to 56581. `data/c/c00685.txt` has sha256 0ad12dcf6875adbd5a3e98a0e2bd264e86b78768435d76c5173748434e954fff. -/

namespace S13K.Chunks.C00685

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00685.txt"

theorem chk : chkChunk S N 56508 74 ces = true := by decide +kernel

theorem ok : RangeOK S N 56508 56582 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00685

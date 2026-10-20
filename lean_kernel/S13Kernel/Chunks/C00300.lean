import S13Kernel.Data.Keys

/-! Keys number 21770 to 21844. `data/c/c00300.txt` has sha256 565bdcda3591135fd0847a7fc538be5d7798b346effe77500e4bc4b0fa70b494. -/

namespace S13K.Chunks.C00300

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00300.txt"

theorem chk : chkChunk S N 21770 75 ces = true := by decide +kernel

theorem ok : RangeOK S N 21770 21845 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00300

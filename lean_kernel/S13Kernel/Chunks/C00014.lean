import S13Kernel.Data.Keys

/-! Keys number 614 to 668. `data/c/c00014.txt` has sha256 b40257164aa7828536508aa8d0041114abb2827004434268a3a576deb6efc70e. -/

namespace S13K.Chunks.C00014

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00014.txt"

theorem chk : chkChunk S N 614 55 ces = true := by decide +kernel

theorem ok : RangeOK S N 614 669 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00014

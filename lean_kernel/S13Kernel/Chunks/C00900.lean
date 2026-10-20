import S13Kernel.Data.Keys

/-! Keys number 77665 to 77778. `data/c/c00900.txt` has sha256 a745c19e64b960274712cafaa3839e6f88daf7dcf66b0b92b01ce758d897706c. -/

namespace S13K.Chunks.C00900

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00900.txt"

theorem chk : chkChunk S N 77665 114 ces = true := by decide +kernel

theorem ok : RangeOK S N 77665 77779 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00900

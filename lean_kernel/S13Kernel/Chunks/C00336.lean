import S13Kernel.Data.Keys

/-! Keys number 24932 to 25008. `data/c/c00336.txt` has sha256 6e44e942949c4d1c853a84632ece660d171d45c15b0cc59960593d2223db7d51. -/

namespace S13K.Chunks.C00336

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00336.txt"

theorem chk : chkChunk S N 24932 77 ces = true := by decide +kernel

theorem ok : RangeOK S N 24932 25009 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00336

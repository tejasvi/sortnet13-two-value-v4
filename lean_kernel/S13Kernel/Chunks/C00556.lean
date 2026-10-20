import S13Kernel.Data.Keys

/-! Keys number 44704 to 44792. `data/c/c00556.txt` has sha256 f55f1152894028f1de6dda8756d1cc35d502cd8d7b86fcbbf0934fb671cf7878. -/

namespace S13K.Chunks.C00556

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00556.txt"

theorem chk : chkChunk S N 44704 89 ces = true := by decide +kernel

theorem ok : RangeOK S N 44704 44793 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00556

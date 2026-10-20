import S13Kernel.Data.Keys

/-! Keys number 59695 to 59797. `data/c/c00718.txt` has sha256 ec000b5b406d37ebacd0ba28a33cf99e64bc3a39f8512fb909d91e28f18be528. -/

namespace S13K.Chunks.C00718

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00718.txt"

theorem chk : chkChunk S N 59695 103 ces = true := by decide +kernel

theorem ok : RangeOK S N 59695 59798 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00718

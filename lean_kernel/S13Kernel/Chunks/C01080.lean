import S13Kernel.Data.Keys

/-! Keys number 97050 to 97167. `data/c/c01080.txt` has sha256 556bacbaceb0843072715749ee95c7b562704f6fe675adbfb3430fc0451ae266. -/

namespace S13K.Chunks.C01080

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01080.txt"

theorem chk : chkChunk S N 97050 118 ces = true := by decide +kernel

theorem ok : RangeOK S N 97050 97168 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01080

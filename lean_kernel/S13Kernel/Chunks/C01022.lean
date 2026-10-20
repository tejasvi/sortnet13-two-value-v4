import S13Kernel.Data.Keys

/-! Keys number 90485 to 90593. `data/c/c01022.txt` has sha256 4e38b5a580b6e41dcf6ba175fbb87d3948c1fe11b8b747c6e916a5296f34b3cf. -/

namespace S13K.Chunks.C01022

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01022.txt"

theorem chk : chkChunk S N 90485 109 ces = true := by decide +kernel

theorem ok : RangeOK S N 90485 90594 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01022

import S13Kernel.Data.Keys

/-! Keys number 44880 to 44972. `data/c/c00558.txt` has sha256 478451c9706ccf40da50cc0cb4aa0b55abf2d40da7545610fba65513c5d78977. -/

namespace S13K.Chunks.C00558

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00558.txt"

theorem chk : chkChunk S N 44880 93 ces = true := by decide +kernel

theorem ok : RangeOK S N 44880 44973 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00558

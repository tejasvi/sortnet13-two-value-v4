import S13Kernel.Data.Keys

/-! Keys number 45642 to 45744. `data/c/c00566.txt` has sha256 ed372593dd04da4c99b7e47bcb1852ea685f55cdac519bc6f8c1d88104e9aef4. -/

namespace S13K.Chunks.C00566

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00566.txt"

theorem chk : chkChunk S N 45642 103 ces = true := by decide +kernel

theorem ok : RangeOK S N 45642 45745 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00566

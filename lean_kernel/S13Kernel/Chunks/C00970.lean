import S13Kernel.Data.Keys

/-! Keys number 84901 to 84994. `data/c/c00970.txt` has sha256 1165d13485ff59f0097cbfb6d061342a42d39af1d1e0ad1db15429f6c902f88d. -/

namespace S13K.Chunks.C00970

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00970.txt"

theorem chk : chkChunk S N 84901 94 ces = true := by decide +kernel

theorem ok : RangeOK S N 84901 84995 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00970

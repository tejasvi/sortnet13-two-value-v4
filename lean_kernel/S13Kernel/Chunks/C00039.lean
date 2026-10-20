import S13Kernel.Data.Keys

/-! Keys number 2038 to 2096. `data/c/c00039.txt` has sha256 6853a948f31c417bf279bf3af3cec1ae21bb8846f98dea46089958b5243ec731. -/

namespace S13K.Chunks.C00039

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00039.txt"

theorem chk : chkChunk S N 2038 59 ces = true := by decide +kernel

theorem ok : RangeOK S N 2038 2097 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00039

import S13Kernel.Data.Keys

/-! Keys number 14801 to 14893. `data/c/c00215.txt` has sha256 c02bab40053f70b154f02b239069b5a67c0df21d5e77938ac37e9930c10943b8. -/

namespace S13K.Chunks.C00215

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00215.txt"

theorem chk : chkChunk S N 14801 93 ces = true := by decide +kernel

theorem ok : RangeOK S N 14801 14894 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00215

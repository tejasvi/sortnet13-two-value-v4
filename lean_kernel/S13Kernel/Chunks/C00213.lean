import S13Kernel.Data.Keys

/-! Keys number 14627 to 14709. `data/c/c00213.txt` has sha256 a56e93a5f53cde803d0f6022832ae77438d865b9fd45f661a9d396f3f702885d. -/

namespace S13K.Chunks.C00213

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00213.txt"

theorem chk : chkChunk S N 14627 83 ces = true := by decide +kernel

theorem ok : RangeOK S N 14627 14710 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00213

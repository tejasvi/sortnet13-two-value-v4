import S13Kernel.Data.Keys

/-! Keys number 11178 to 11247. `data/c/c00169.txt` has sha256 f0c516ad9d1b20e33491068a7da41fbdde66682a89934b4eb5a6ab62b92329aa. -/

namespace S13K.Chunks.C00169

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00169.txt"

theorem chk : chkChunk S N 11178 70 ces = true := by decide +kernel

theorem ok : RangeOK S N 11178 11248 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00169

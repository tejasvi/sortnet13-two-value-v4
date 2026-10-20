import S13Kernel.Data.Keys

/-! Keys number 40658 to 40743. `data/c/c00514.txt` has sha256 9e00f2a9a43feca1709045c3e455dcf204e54b2c6c3697a431051870eb6a431c. -/

namespace S13K.Chunks.C00514

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00514.txt"

theorem chk : chkChunk S N 40658 86 ces = true := by decide +kernel

theorem ok : RangeOK S N 40658 40744 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00514

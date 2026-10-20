import S13Kernel.Data.Keys

/-! Keys number 80651 to 80749. `data/c/c00929.txt` has sha256 3f8d062f7b72a7e1bab4d496688c282b575275d4fe45dafd4a5ca45f4e74f7f8. -/

namespace S13K.Chunks.C00929

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00929.txt"

theorem chk : chkChunk S N 80651 99 ces = true := by decide +kernel

theorem ok : RangeOK S N 80651 80750 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00929

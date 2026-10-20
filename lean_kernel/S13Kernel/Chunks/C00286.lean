import S13Kernel.Data.Keys

/-! Keys number 20715 to 20765. `data/c/c00286.txt` has sha256 0873555655a184b195af767c8e756634ff9000c573c7f062ac7e00b4ac79efe3. -/

namespace S13K.Chunks.C00286

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00286.txt"

theorem chk : chkChunk S N 20715 51 ces = true := by decide +kernel

theorem ok : RangeOK S N 20715 20766 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00286

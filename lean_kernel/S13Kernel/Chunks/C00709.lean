import S13Kernel.Data.Keys

/-! Keys number 58724 to 58825. `data/c/c00709.txt` has sha256 3546231674f7e0373fb64d181f0c93fdc6f61f964f8fcbae7367869ecf5d8b11. -/

namespace S13K.Chunks.C00709

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00709.txt"

theorem chk : chkChunk S N 58724 102 ces = true := by decide +kernel

theorem ok : RangeOK S N 58724 58826 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00709

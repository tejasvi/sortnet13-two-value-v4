import S13Kernel.Data.Keys

/-! Keys number 86643 to 86734. `data/c/c00987.txt` has sha256 7fba05814df7b30db322289f706bad001334cd14484494650899f4be189a1ec9. -/

namespace S13K.Chunks.C00987

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00987.txt"

theorem chk : chkChunk S N 86643 92 ces = true := by decide +kernel

theorem ok : RangeOK S N 86643 86735 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00987

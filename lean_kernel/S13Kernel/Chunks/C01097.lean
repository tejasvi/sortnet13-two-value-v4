import S13Kernel.Data.Keys

/-! Keys number 99103 to 99229. `data/c/c01097.txt` has sha256 63b72a0f5e1f701f10b4520fbe884aada4bdd843e7577c0c8d0f835764c08f59. -/

namespace S13K.Chunks.C01097

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01097.txt"

theorem chk : chkChunk S N 99103 127 ces = true := by decide +kernel

theorem ok : RangeOK S N 99103 99230 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01097

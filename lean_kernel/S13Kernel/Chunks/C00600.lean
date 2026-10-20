import S13Kernel.Data.Keys

/-! Keys number 48801 to 48878. `data/c/c00600.txt` has sha256 df40e8730a764b2a80877bedfc6f71683843703a64c888eec7f07ec657167c1d. -/

namespace S13K.Chunks.C00600

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00600.txt"

theorem chk : chkChunk S N 48801 78 ces = true := by decide +kernel

theorem ok : RangeOK S N 48801 48879 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00600

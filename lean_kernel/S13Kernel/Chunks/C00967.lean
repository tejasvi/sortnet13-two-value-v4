import S13Kernel.Data.Keys

/-! Keys number 84602 to 84694. `data/c/c00967.txt` has sha256 08dacde3e23fc904451d378fbd9b5744f31f1670073953e20ae09ad3ae4d5a65. -/

namespace S13K.Chunks.C00967

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00967.txt"

theorem chk : chkChunk S N 84602 93 ces = true := by decide +kernel

theorem ok : RangeOK S N 84602 84695 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00967

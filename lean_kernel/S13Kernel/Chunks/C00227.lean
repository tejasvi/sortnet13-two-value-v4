import S13Kernel.Data.Keys

/-! Keys number 15793 to 15890. `data/c/c00227.txt` has sha256 b17e75689dd26cae8927475f8107bc860c06457de8da1a999acff0ef57839329. -/

namespace S13K.Chunks.C00227

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00227.txt"

theorem chk : chkChunk S N 15793 98 ces = true := by decide +kernel

theorem ok : RangeOK S N 15793 15891 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00227

import S13Kernel.Data.Keys

/-! Keys number 8070 to 8156. `data/c/c00128.txt` has sha256 8cd13c91c1a2c91302959ddb1e6ed8c908e5e02c2c506e401c5cb600ab29d2df. -/

namespace S13K.Chunks.C00128

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00128.txt"

theorem chk : chkChunk S N 8070 87 ces = true := by decide +kernel

theorem ok : RangeOK S N 8070 8157 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00128

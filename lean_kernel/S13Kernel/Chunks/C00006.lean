import S13Kernel.Data.Keys

/-! Keys number 235 to 276. `data/c/c00006.txt` has sha256 de622adcf02607df9be9b8eb7f09ff47b31835e268522f4799a129d4d8fd3bb2. -/

namespace S13K.Chunks.C00006

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00006.txt"

theorem chk : chkChunk S N 235 42 ces = true := by decide +kernel

theorem ok : RangeOK S N 235 277 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00006

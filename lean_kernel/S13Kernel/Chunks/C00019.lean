import S13Kernel.Data.Keys

/-! Keys number 890 to 935. `data/c/c00019.txt` has sha256 e1c901f10f7b2cd5a5d117b9e93120276f9ad64cd04118adcf6b9c881e4777b9. -/

namespace S13K.Chunks.C00019

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00019.txt"

theorem chk : chkChunk S N 890 46 ces = true := by decide +kernel

theorem ok : RangeOK S N 890 936 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00019

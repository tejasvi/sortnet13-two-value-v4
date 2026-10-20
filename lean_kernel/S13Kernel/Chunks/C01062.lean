import S13Kernel.Data.Keys

/-! Keys number 94943 to 95049. `data/c/c01062.txt` has sha256 13bb8d42e0798731dd869a0c886e01031a7cb57eeaf0675e840bebc3882e5c15. -/

namespace S13K.Chunks.C01062

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01062.txt"

theorem chk : chkChunk S N 94943 107 ces = true := by decide +kernel

theorem ok : RangeOK S N 94943 95050 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01062

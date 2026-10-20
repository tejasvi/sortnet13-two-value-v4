import S13Kernel.Data.Keys

/-! Keys number 20008 to 20083. `data/c/c00276.txt` has sha256 35a625656693ac531e93bf5d362c5a3bd3e333abb6ab687916e5d6607f5984dd. -/

namespace S13K.Chunks.C00276

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00276.txt"

theorem chk : chkChunk S N 20008 76 ces = true := by decide +kernel

theorem ok : RangeOK S N 20008 20084 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00276

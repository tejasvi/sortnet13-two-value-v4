import S13Kernel.Data.Keys

/-! Keys number 832 to 889. `data/c/c00018.txt` has sha256 b4c2823dcb2fc993565e4fc899577b546b6c09a908f95f36eff5d9ca18b53e17. -/

namespace S13K.Chunks.C00018

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00018.txt"

theorem chk : chkChunk S N 832 58 ces = true := by decide +kernel

theorem ok : RangeOK S N 832 890 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00018

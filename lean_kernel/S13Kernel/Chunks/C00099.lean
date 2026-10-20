import S13Kernel.Data.Keys

/-! Keys number 5878 to 5938. `data/c/c00099.txt` has sha256 1554b64f3df0c6dfac40b0d32116ed016fe7fb20c4568bbec07330f5958251f6. -/

namespace S13K.Chunks.C00099

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00099.txt"

theorem chk : chkChunk S N 5878 61 ces = true := by decide +kernel

theorem ok : RangeOK S N 5878 5939 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00099

import S13Kernel.Data.Keys

/-! Keys number 91041 to 91147. `data/c/c01027.txt` has sha256 2048ff7579a096d2feb0beda3a1a9d4f5cb43cd13906cfcefb913df9758e4e7e. -/

namespace S13K.Chunks.C01027

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01027.txt"

theorem chk : chkChunk S N 91041 107 ces = true := by decide +kernel

theorem ok : RangeOK S N 91041 91148 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01027

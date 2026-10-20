import S13Kernel.Data.Keys

/-! Keys number 94709 to 94825. `data/c/c01060.txt` has sha256 b82f42e8745ad72fd1c1f7bab705415b809ab8abb01ae9d62f011a303dc9745d. -/

namespace S13K.Chunks.C01060

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01060.txt"

theorem chk : chkChunk S N 94709 117 ces = true := by decide +kernel

theorem ok : RangeOK S N 94709 94826 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01060

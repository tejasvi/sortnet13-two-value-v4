import S13Kernel.Data.Keys

/-! Keys number 83046 to 83144. `data/c/c00953.txt` has sha256 23dce9a39e447ac07db0879bbe8eec8b083c6e803d0d5270b1b89f888648ba58. -/

namespace S13K.Chunks.C00953

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00953.txt"

theorem chk : chkChunk S N 83046 99 ces = true := by decide +kernel

theorem ok : RangeOK S N 83046 83145 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00953

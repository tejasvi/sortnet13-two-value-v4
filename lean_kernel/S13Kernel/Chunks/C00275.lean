import S13Kernel.Data.Keys

/-! Keys number 19936 to 20007. `data/c/c00275.txt` has sha256 9b52cd02fc4532c6f7b26dc961695bac88867c21c4ad4469b56fd3cb8bae9fae. -/

namespace S13K.Chunks.C00275

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00275.txt"

theorem chk : chkChunk S N 19936 72 ces = true := by decide +kernel

theorem ok : RangeOK S N 19936 20008 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00275

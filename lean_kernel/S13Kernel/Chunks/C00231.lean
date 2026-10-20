import S13Kernel.Data.Keys

/-! Keys number 16174 to 16240. `data/c/c00231.txt` has sha256 42c8f0accb4432f04390a51c9b50ee569290d004f2afb82ff6ac834f0b38004d. -/

namespace S13K.Chunks.C00231

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00231.txt"

theorem chk : chkChunk S N 16174 67 ces = true := by decide +kernel

theorem ok : RangeOK S N 16174 16241 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00231

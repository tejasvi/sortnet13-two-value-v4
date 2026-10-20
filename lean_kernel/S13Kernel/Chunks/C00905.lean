import S13Kernel.Data.Keys

/-! Keys number 78212 to 78300. `data/c/c00905.txt` has sha256 5e646c6b06e34dc8f148c5e7298ca41f0ed96e247e01bacf5d69c02b02fc5b8d. -/

namespace S13K.Chunks.C00905

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00905.txt"

theorem chk : chkChunk S N 78212 89 ces = true := by decide +kernel

theorem ok : RangeOK S N 78212 78301 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00905

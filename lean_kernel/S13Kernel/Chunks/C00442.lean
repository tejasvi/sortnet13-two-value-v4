import S13Kernel.Data.Keys

/-! Keys number 34255 to 34342. `data/c/c00442.txt` has sha256 8838792f7fbeea52b461c6af4a2bdb2cb780da7cb15e6ffde5016b74a0a0be86. -/

namespace S13K.Chunks.C00442

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00442.txt"

theorem chk : chkChunk S N 34255 88 ces = true := by decide +kernel

theorem ok : RangeOK S N 34255 34343 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00442

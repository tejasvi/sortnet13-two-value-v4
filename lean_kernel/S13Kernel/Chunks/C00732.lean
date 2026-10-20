import S13Kernel.Data.Keys

/-! Keys number 61138 to 61235. `data/c/c00732.txt` has sha256 e330a73d31c94bbb22c7d3cd4909c7760b9c70b04f91f0375d922b1f0f2b37a6. -/

namespace S13K.Chunks.C00732

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00732.txt"

theorem chk : chkChunk S N 61138 98 ces = true := by decide +kernel

theorem ok : RangeOK S N 61138 61236 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00732

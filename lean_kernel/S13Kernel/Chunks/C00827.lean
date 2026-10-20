import S13Kernel.Data.Keys

/-! Keys number 70364 to 70445. `data/c/c00827.txt` has sha256 d337c372d501a56390d01e724347b077c3d7aa5357da5979d200b03ab52d23c8. -/

namespace S13K.Chunks.C00827

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00827.txt"

theorem chk : chkChunk S N 70364 82 ces = true := by decide +kernel

theorem ok : RangeOK S N 70364 70446 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00827

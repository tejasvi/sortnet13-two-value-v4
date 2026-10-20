import S13Kernel.Data.Keys

/-! Keys number 11841 to 11902. `data/c/c00179.txt` has sha256 9c818f514108197da9e937134e07e66556c2f37d806057675bd480f300765a45. -/

namespace S13K.Chunks.C00179

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00179.txt"

theorem chk : chkChunk S N 11841 62 ces = true := by decide +kernel

theorem ok : RangeOK S N 11841 11903 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00179

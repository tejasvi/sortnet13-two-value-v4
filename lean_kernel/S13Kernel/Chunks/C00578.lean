import S13Kernel.Data.Keys

/-! Keys number 46734 to 46833. `data/c/c00578.txt` has sha256 62d7cc061c55f55fa7b8ae5686f63d74404c334c35988a76fad1998064ccc5d6. -/

namespace S13K.Chunks.C00578

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00578.txt"

theorem chk : chkChunk S N 46734 100 ces = true := by decide +kernel

theorem ok : RangeOK S N 46734 46834 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00578

import S13Kernel.Data.Keys

/-! Keys number 16556 to 16647. `data/c/c00236.txt` has sha256 baf855605ea38c9687b075da2be5acc194ab293869c776b71a942be2863797d4. -/

namespace S13K.Chunks.C00236

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00236.txt"

theorem chk : chkChunk S N 16556 92 ces = true := by decide +kernel

theorem ok : RangeOK S N 16556 16648 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00236

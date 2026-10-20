import S13Kernel.Data.Keys

/-! Keys number 57796 to 57883. `data/c/c00699.txt` has sha256 3a708231c3848c2e443acf8c2162967baa1332ceafd9144271a77b266ff3116c. -/

namespace S13K.Chunks.C00699

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00699.txt"

theorem chk : chkChunk S N 57796 88 ces = true := by decide +kernel

theorem ok : RangeOK S N 57796 57884 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00699

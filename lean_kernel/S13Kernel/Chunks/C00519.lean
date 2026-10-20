import S13Kernel.Data.Keys

/-! Keys number 41097 to 41186. `data/c/c00519.txt` has sha256 8969f61bbf274c20d5c55016333ee8bb4926dcdcbd972235a9965099ebcc8d21. -/

namespace S13K.Chunks.C00519

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00519.txt"

theorem chk : chkChunk S N 41097 90 ces = true := by decide +kernel

theorem ok : RangeOK S N 41097 41187 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00519

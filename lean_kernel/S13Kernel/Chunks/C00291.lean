import S13Kernel.Data.Keys

/-! Keys number 21067 to 21149. `data/c/c00291.txt` has sha256 ca00d9687100d64584c4213953155344c1e2eabd91fd19905e23f052f6c43233. -/

namespace S13K.Chunks.C00291

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00291.txt"

theorem chk : chkChunk S N 21067 83 ces = true := by decide +kernel

theorem ok : RangeOK S N 21067 21150 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00291

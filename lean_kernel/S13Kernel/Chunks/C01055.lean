import S13Kernel.Data.Keys

/-! Keys number 94150 to 94266. `data/c/c01055.txt` has sha256 4f846a1bea914c016c8a38851f8983b5e8662805d5aede3738b963152651173f. -/

namespace S13K.Chunks.C01055

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01055.txt"

theorem chk : chkChunk S N 94150 117 ces = true := by decide +kernel

theorem ok : RangeOK S N 94150 94267 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01055

import S13Kernel.Data.Keys

/-! Keys number 87779 to 87898. `data/c/c00998.txt` has sha256 6783d4476c82804aff792e6fbfa114118a735f7bb24e294522944834af6834ec. -/

namespace S13K.Chunks.C00998

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00998.txt"

theorem chk : chkChunk S N 87779 120 ces = true := by decide +kernel

theorem ok : RangeOK S N 87779 87899 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00998

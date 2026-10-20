import S13Kernel.Data.Keys

/-! Keys number 16745 to 16838. `data/c/c00238.txt` has sha256 59d79fa443174b417bc16d8d1ebd9e61d14c23a379d8f18a5a03245754c8b604. -/

namespace S13K.Chunks.C00238

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00238.txt"

theorem chk : chkChunk S N 16745 94 ces = true := by decide +kernel

theorem ok : RangeOK S N 16745 16839 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00238

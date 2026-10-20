import S13Kernel.Data.Keys

/-! Keys number 67243 to 67337. `data/c/c00796.txt` has sha256 9297af4808368fcc3e49638cfbbd3e6c35c23278463f8c70f00c7e0c084e7d10. -/

namespace S13K.Chunks.C00796

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00796.txt"

theorem chk : chkChunk S N 67243 95 ces = true := by decide +kernel

theorem ok : RangeOK S N 67243 67338 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00796

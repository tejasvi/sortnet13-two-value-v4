import S13Kernel.Data.Keys

/-! Keys number 142 to 189. `data/c/c00004.txt` has sha256 998f706c9b7cb19fb69bc0f1b2c9df28de8a0c3264edd4602b740755e2d1dfb9. -/

namespace S13K.Chunks.C00004

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00004.txt"

theorem chk : chkChunk S N 142 48 ces = true := by decide +kernel

theorem ok : RangeOK S N 142 190 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00004

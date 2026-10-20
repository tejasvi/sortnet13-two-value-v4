import S13Kernel.Data.Keys

/-! Keys number 12200 to 12281. `data/c/c00184.txt` has sha256 9737aea38c362db8b9679c51bbd7f952b602deed2d7c42e214232ef3611de893. -/

namespace S13K.Chunks.C00184

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00184.txt"

theorem chk : chkChunk S N 12200 82 ces = true := by decide +kernel

theorem ok : RangeOK S N 12200 12282 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00184

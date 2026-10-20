import S13Kernel.Data.Keys

/-! Keys number 65889 to 65974. `data/c/c00781.txt` has sha256 124752a52ee0dcef84afce6458123e3781bdf12393ad4d1b8251ee1b33129987. -/

namespace S13K.Chunks.C00781

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00781.txt"

theorem chk : chkChunk S N 65889 86 ces = true := by decide +kernel

theorem ok : RangeOK S N 65889 65975 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00781

import S13Kernel.Data.Keys

/-! Keys number 56869 to 56955. `data/c/c00689.txt` has sha256 2200c0a7348ef46ad88bff6f7f22f3d910598e7961dd47182605d13c73bdb9f7. -/

namespace S13K.Chunks.C00689

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00689.txt"

theorem chk : chkChunk S N 56869 87 ces = true := by decide +kernel

theorem ok : RangeOK S N 56869 56956 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00689

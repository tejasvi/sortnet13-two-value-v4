import S13Kernel.Data.Keys

/-! Keys number 48271 to 48372. `data/c/c00594.txt` has sha256 6120e0171c333e19fa3572e5ffd8c252baed6de3402de07f2d0b36028352eb13. -/

namespace S13K.Chunks.C00594

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00594.txt"

theorem chk : chkChunk S N 48271 102 ces = true := by decide +kernel

theorem ok : RangeOK S N 48271 48373 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00594

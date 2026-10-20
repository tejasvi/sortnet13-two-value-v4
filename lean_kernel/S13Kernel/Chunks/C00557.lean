import S13Kernel.Data.Keys

/-! Keys number 44793 to 44879. `data/c/c00557.txt` has sha256 fdf1e7bbbb6dd1d10319096dd603211428db88921245603e16c5db90c4f880b4. -/

namespace S13K.Chunks.C00557

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00557.txt"

theorem chk : chkChunk S N 44793 87 ces = true := by decide +kernel

theorem ok : RangeOK S N 44793 44880 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00557

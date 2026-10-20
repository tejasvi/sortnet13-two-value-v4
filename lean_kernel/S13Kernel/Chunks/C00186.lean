import S13Kernel.Data.Keys

/-! Keys number 12347 to 12430. `data/c/c00186.txt` has sha256 5204cafeda55c1d14e85e7677b01ca182ed69eb8151e95462d108408ff7abf00. -/

namespace S13K.Chunks.C00186

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00186.txt"

theorem chk : chkChunk S N 12347 84 ces = true := by decide +kernel

theorem ok : RangeOK S N 12347 12431 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00186

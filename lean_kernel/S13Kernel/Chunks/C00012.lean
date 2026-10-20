import S13Kernel.Data.Keys

/-! Keys number 510 to 567. `data/c/c00012.txt` has sha256 de268e22e53a17ebb9e7835caeb6b2d0c54802f341ce7cdcb7bc4a0bf615c214. -/

namespace S13K.Chunks.C00012

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00012.txt"

theorem chk : chkChunk S N 510 58 ces = true := by decide +kernel

theorem ok : RangeOK S N 510 568 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00012

import S13Kernel.Data.Keys

/-! Keys number 31431 to 31536. `data/c/c00408.txt` has sha256 a3a723b61a3dace79754d86dca90ebd71212f92fda5e5c6b0b47b645710ca008. -/

namespace S13K.Chunks.C00408

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00408.txt"

theorem chk : chkChunk S N 31431 106 ces = true := by decide +kernel

theorem ok : RangeOK S N 31431 31537 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00408

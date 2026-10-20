import S13Kernel.Data.Keys

/-! Keys number 46220 to 46299. `data/c/c00572.txt` has sha256 aaad1ae5bae4bfe2d4148b6815f212567638b1f6cf07d6d12fbd95b5808b65a8. -/

namespace S13K.Chunks.C00572

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00572.txt"

theorem chk : chkChunk S N 46220 80 ces = true := by decide +kernel

theorem ok : RangeOK S N 46220 46300 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00572

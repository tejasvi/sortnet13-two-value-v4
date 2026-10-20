import S13Kernel.Data.Keys

/-! Keys number 50803 to 50892. `data/c/c00624.txt` has sha256 e8931b4de0ef7f92e064bafc3d45311f64cd386fef399876b9a6ab28e5d1f3f8. -/

namespace S13K.Chunks.C00624

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00624.txt"

theorem chk : chkChunk S N 50803 90 ces = true := by decide +kernel

theorem ok : RangeOK S N 50803 50893 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00624

import S13Kernel.Data.Keys

/-! Keys number 82635 to 82734. `data/c/c00949.txt` has sha256 ad311538a35c5b72a4864b3374dc8b3642762c248dc3d3fa5ddbd853b6c0d190. -/

namespace S13K.Chunks.C00949

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00949.txt"

theorem chk : chkChunk S N 82635 100 ces = true := by decide +kernel

theorem ok : RangeOK S N 82635 82735 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00949

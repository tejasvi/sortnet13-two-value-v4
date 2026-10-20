import S13Kernel.Data.Keys

/-! Keys number 28052 to 28148. `data/c/c00371.txt` has sha256 ced929fff31cb17179215ebec1de8ff0d3d3266337c3a258f6e2a5f02e5d95b8. -/

namespace S13K.Chunks.C00371

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00371.txt"

theorem chk : chkChunk S N 28052 97 ces = true := by decide +kernel

theorem ok : RangeOK S N 28052 28149 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00371

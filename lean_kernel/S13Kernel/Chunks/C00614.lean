import S13Kernel.Data.Keys

/-! Keys number 49948 to 50034. `data/c/c00614.txt` has sha256 217d90959bbc8275f8897c714a1042679f3b30c9a6e66d3a53b9d5122c0b75a7. -/

namespace S13K.Chunks.C00614

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00614.txt"

theorem chk : chkChunk S N 49948 87 ces = true := by decide +kernel

theorem ok : RangeOK S N 49948 50035 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00614

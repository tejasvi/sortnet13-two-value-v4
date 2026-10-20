import S13Kernel.Data.Keys

/-! Keys number 6071 to 6144. `data/c/c00102.txt` has sha256 6d2b9c8f0367be309e73b7405d031ad4f3a83892a278787a217c8736013f4191. -/

namespace S13K.Chunks.C00102

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00102.txt"

theorem chk : chkChunk S N 6071 74 ces = true := by decide +kernel

theorem ok : RangeOK S N 6071 6145 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00102

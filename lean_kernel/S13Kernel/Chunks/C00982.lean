import S13Kernel.Data.Keys

/-! Keys number 86151 to 86247. `data/c/c00982.txt` has sha256 b73551a70673740b7223c1282afd15c0d3a418b3a1164da60fe80fb6b9ce7f29. -/

namespace S13K.Chunks.C00982

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00982.txt"

theorem chk : chkChunk S N 86151 97 ces = true := by decide +kernel

theorem ok : RangeOK S N 86151 86248 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00982

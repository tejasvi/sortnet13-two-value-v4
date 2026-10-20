import S13Kernel.Data.Keys

/-! Keys number 9767 to 9849. `data/c/c00149.txt` has sha256 8f0f5a7380ce49bc4fd78d387ee9f5d9ba76dda149dcd97cdfd47969d929c798. -/

namespace S13K.Chunks.C00149

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00149.txt"

theorem chk : chkChunk S N 9767 83 ces = true := by decide +kernel

theorem ok : RangeOK S N 9767 9850 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00149

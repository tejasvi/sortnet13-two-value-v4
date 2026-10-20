import S13Kernel.Data.Keys

/-! Keys number 17099 to 17192. `data/c/c00242.txt` has sha256 bd076d66e265a0fbe30c5ca605d62e93a936a63dc2a1f4e84b0de02d05254a6d. -/

namespace S13K.Chunks.C00242

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00242.txt"

theorem chk : chkChunk S N 17099 94 ces = true := by decide +kernel

theorem ok : RangeOK S N 17099 17193 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00242

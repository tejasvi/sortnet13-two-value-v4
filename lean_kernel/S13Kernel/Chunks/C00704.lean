import S13Kernel.Data.Keys

/-! Keys number 58245 to 58331. `data/c/c00704.txt` has sha256 2218f6cd4e5b688706bbe0902413cc63f9414b5bf96b8a80b7f6832ceea9b3a5. -/

namespace S13K.Chunks.C00704

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00704.txt"

theorem chk : chkChunk S N 58245 87 ces = true := by decide +kernel

theorem ok : RangeOK S N 58245 58332 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00704

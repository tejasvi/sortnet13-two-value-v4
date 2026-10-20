import S13Kernel.Data.Keys

/-! Keys number 27743 to 27843. `data/c/c00368.txt` has sha256 dce2231854d09193bf1a7d2f645098b2aed029e4062762c4245092153f009716. -/

namespace S13K.Chunks.C00368

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00368.txt"

theorem chk : chkChunk S N 27743 101 ces = true := by decide +kernel

theorem ok : RangeOK S N 27743 27844 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00368

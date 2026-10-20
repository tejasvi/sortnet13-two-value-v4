import S13Kernel.Data.Keys

/-! Keys number 8530 to 8602. `data/c/c00134.txt` has sha256 455b5df0962589f739ec5508f9ff1f50164e0e301a796c9d69958509783085a4. -/

namespace S13K.Chunks.C00134

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00134.txt"

theorem chk : chkChunk S N 8530 73 ces = true := by decide +kernel

theorem ok : RangeOK S N 8530 8603 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00134

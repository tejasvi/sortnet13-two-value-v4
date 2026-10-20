import S13Kernel.Data.Keys

/-! Keys number 29483 to 29571. `data/c/c00386.txt` has sha256 5d5462f04e5eb3d8dc01b2549b4e77b198b760360b88af726c0d910e7d383f74. -/

namespace S13K.Chunks.C00386

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00386.txt"

theorem chk : chkChunk S N 29483 89 ces = true := by decide +kernel

theorem ok : RangeOK S N 29483 29572 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00386

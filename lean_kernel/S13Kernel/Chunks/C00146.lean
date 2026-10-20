import S13Kernel.Data.Keys

/-! Keys number 9514 to 9589. `data/c/c00146.txt` has sha256 14aa0a1294637ed15681a2bfc19cc4534c2caf8bd90ab209b7d15c9a573fa2b8. -/

namespace S13K.Chunks.C00146

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00146.txt"

theorem chk : chkChunk S N 9514 76 ces = true := by decide +kernel

theorem ok : RangeOK S N 9514 9590 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00146

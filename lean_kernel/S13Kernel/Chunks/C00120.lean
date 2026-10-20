import S13Kernel.Data.Keys

/-! Keys number 7482 to 7544. `data/c/c00120.txt` has sha256 629b801115e6aa891b94e06125674892b1d03e973cfe91ead6cd9f76e22a9cd6. -/

namespace S13K.Chunks.C00120

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00120.txt"

theorem chk : chkChunk S N 7482 63 ces = true := by decide +kernel

theorem ok : RangeOK S N 7482 7545 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00120

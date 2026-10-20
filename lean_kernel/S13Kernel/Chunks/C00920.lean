import S13Kernel.Data.Keys

/-! Keys number 79715 to 79818. `data/c/c00920.txt` has sha256 96b3830277b6f8ae30b16651614ee901e56dd60dbd93feb8d8a81f02b756e68c. -/

namespace S13K.Chunks.C00920

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00920.txt"

theorem chk : chkChunk S N 79715 104 ces = true := by decide +kernel

theorem ok : RangeOK S N 79715 79819 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00920

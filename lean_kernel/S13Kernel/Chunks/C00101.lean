import S13Kernel.Data.Keys

/-! Keys number 5998 to 6070. `data/c/c00101.txt` has sha256 419e9350f4899e171ee2eab59f108f6e67729b8031de85e35d19cf895b78853d. -/

namespace S13K.Chunks.C00101

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00101.txt"

theorem chk : chkChunk S N 5998 73 ces = true := by decide +kernel

theorem ok : RangeOK S N 5998 6071 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00101

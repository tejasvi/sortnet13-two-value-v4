import S13Kernel.Data.Keys

/-! Keys number 51072 to 51154. `data/c/c00627.txt` has sha256 689042942524a5c8c39bd1f21990e3e0183f10325face7a96c7c67540ad96d9a. -/

namespace S13K.Chunks.C00627

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00627.txt"

theorem chk : chkChunk S N 51072 83 ces = true := by decide +kernel

theorem ok : RangeOK S N 51072 51155 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00627

import S13Kernel.Data.Keys

/-! Keys number 85438 to 85540. `data/c/c00975.txt` has sha256 d497c3e31caca222bdf39dea136d5ca38982cfd2591beb00df75a79ec75e33a5. -/

namespace S13K.Chunks.C00975

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00975.txt"

theorem chk : chkChunk S N 85438 103 ces = true := by decide +kernel

theorem ok : RangeOK S N 85438 85541 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00975

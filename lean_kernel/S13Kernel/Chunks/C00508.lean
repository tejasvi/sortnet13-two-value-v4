import S13Kernel.Data.Keys

/-! Keys number 40140 to 40223. `data/c/c00508.txt` has sha256 e58f0a88a202b36597afaf0da25eb392763ed79765a4fd16590fdc2b676d0ef5. -/

namespace S13K.Chunks.C00508

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00508.txt"

theorem chk : chkChunk S N 40140 84 ces = true := by decide +kernel

theorem ok : RangeOK S N 40140 40224 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00508

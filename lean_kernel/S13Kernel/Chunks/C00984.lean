import S13Kernel.Data.Keys

/-! Keys number 86348 to 86453. `data/c/c00984.txt` has sha256 24bf7fba7f91fb904ae92f7f2cd4e75f5a6eadfaf27a8bd08f1457719f446356. -/

namespace S13K.Chunks.C00984

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00984.txt"

theorem chk : chkChunk S N 86348 106 ces = true := by decide +kernel

theorem ok : RangeOK S N 86348 86454 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00984

import S13Kernel.Data.Keys

/-! Keys number 60467 to 60561. `data/c/c00725.txt` has sha256 6b7db80d358a4c4b31bb9866d024295af166db9a9804cd7e3e095cd02bbbf19e. -/

namespace S13K.Chunks.C00725

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00725.txt"

theorem chk : chkChunk S N 60467 95 ces = true := by decide +kernel

theorem ok : RangeOK S N 60467 60562 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00725

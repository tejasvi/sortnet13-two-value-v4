import S13Kernel.Data.Keys

/-! Keys number 11640 to 11700. `data/c/c00176.txt` has sha256 21574c317d859a96a58ed222f2e8aa4f5ccc903196f134b72c3d2c6281530a00. -/

namespace S13K.Chunks.C00176

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00176.txt"

theorem chk : chkChunk S N 11640 61 ces = true := by decide +kernel

theorem ok : RangeOK S N 11640 11701 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00176

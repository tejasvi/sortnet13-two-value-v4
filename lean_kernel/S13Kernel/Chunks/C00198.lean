import S13Kernel.Data.Keys

/-! Keys number 13452 to 13535. `data/c/c00198.txt` has sha256 05d320956b53bb97a67254a70cb91e2a839d7513c34237848dcec61402b9b906. -/

namespace S13K.Chunks.C00198

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00198.txt"

theorem chk : chkChunk S N 13452 84 ces = true := by decide +kernel

theorem ok : RangeOK S N 13452 13536 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00198

import S13Kernel.Data.Keys

/-! Keys number 32714 to 32794. `data/c/c00422.txt` has sha256 e2512d4ca40e9ce430f20d9143db14b85cd16474c83addf23492b47569d43c35. -/

namespace S13K.Chunks.C00422

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00422.txt"

theorem chk : chkChunk S N 32714 81 ces = true := by decide +kernel

theorem ok : RangeOK S N 32714 32795 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00422

import S13Kernel.Data.Keys

/-! Keys number 39122 to 39199. `data/c/c00496.txt` has sha256 2367e15b42fb098a17a7036bea218a64f02b399d1474d1822e2efd5cac59fbff. -/

namespace S13K.Chunks.C00496

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00496.txt"

theorem chk : chkChunk S N 39122 78 ces = true := by decide +kernel

theorem ok : RangeOK S N 39122 39200 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00496

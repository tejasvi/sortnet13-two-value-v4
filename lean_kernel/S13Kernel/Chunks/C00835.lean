import S13Kernel.Data.Keys

/-! Keys number 71100 to 71213. `data/c/c00835.txt` has sha256 24cda8c039106cffab312bb6b0141bb23a04b97f9a3ac2321e9dadc93183c9c0. -/

namespace S13K.Chunks.C00835

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00835.txt"

theorem chk : chkChunk S N 71100 114 ces = true := by decide +kernel

theorem ok : RangeOK S N 71100 71214 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00835

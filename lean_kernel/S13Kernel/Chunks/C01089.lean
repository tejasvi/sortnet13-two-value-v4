import S13Kernel.Data.Keys

/-! Keys number 98120 to 98239. `data/c/c01089.txt` has sha256 de47aac75a0051f84f5091271405c3da1e3dcdeb8ff8a8f3a425801097437eef. -/

namespace S13K.Chunks.C01089

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01089.txt"

theorem chk : chkChunk S N 98120 120 ces = true := by decide +kernel

theorem ok : RangeOK S N 98120 98240 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01089

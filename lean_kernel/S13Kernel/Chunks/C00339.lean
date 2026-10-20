import S13Kernel.Data.Keys

/-! Keys number 25215 to 25323. `data/c/c00339.txt` has sha256 8ba2ce89549ef93f6029b7486505d70638b453b0bca7574e66736de74b96f15e. -/

namespace S13K.Chunks.C00339

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00339.txt"

theorem chk : chkChunk S N 25215 109 ces = true := by decide +kernel

theorem ok : RangeOK S N 25215 25324 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00339

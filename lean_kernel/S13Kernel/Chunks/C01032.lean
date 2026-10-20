import S13Kernel.Data.Keys

/-! Keys number 91598 to 91700. `data/c/c01032.txt` has sha256 309e13d844ec2f2edaebb71bd0ae447f43b341c91588d9cec44d21003ce697ab. -/

namespace S13K.Chunks.C01032

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01032.txt"

theorem chk : chkChunk S N 91598 103 ces = true := by decide +kernel

theorem ok : RangeOK S N 91598 91701 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01032

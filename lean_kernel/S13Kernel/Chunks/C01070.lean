import S13Kernel.Data.Keys

/-! Keys number 95852 to 95976. `data/c/c01070.txt` has sha256 b3da6ce25a96083bef4984520ae12bcdf8a84d310dd9f966614a7f38092ff39a. -/

namespace S13K.Chunks.C01070

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01070.txt"

theorem chk : chkChunk S N 95852 125 ces = true := by decide +kernel

theorem ok : RangeOK S N 95852 95977 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01070

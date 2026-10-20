import S13Kernel.Data.Keys

/-! Keys number 92136 to 92235. `data/c/c01037.txt` has sha256 b669d47ccc27a8f866f10371b3de0086fea22d7bceca5803eb8e36d5b42a7bb4. -/

namespace S13K.Chunks.C01037

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01037.txt"

theorem chk : chkChunk S N 92136 100 ces = true := by decide +kernel

theorem ok : RangeOK S N 92136 92236 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01037

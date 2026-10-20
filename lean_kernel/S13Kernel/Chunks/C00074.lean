import S13Kernel.Data.Keys

/-! Keys number 4243 to 4323. `data/c/c00074.txt` has sha256 542987d6088edead1fcde1b27df8fe4e68e62fabcf9d9c29efecd9f1fc9ea3f3. -/

namespace S13K.Chunks.C00074

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00074.txt"

theorem chk : chkChunk S N 4243 81 ces = true := by decide +kernel

theorem ok : RangeOK S N 4243 4324 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00074

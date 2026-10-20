import S13Kernel.Data.Keys

/-! Keys number 28760 to 28859. `data/c/c00379.txt` has sha256 34623230d1f482959b7edb926293feb6f1c8e91b65e8598010c431b868348df2. -/

namespace S13K.Chunks.C00379

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00379.txt"

theorem chk : chkChunk S N 28760 100 ces = true := by decide +kernel

theorem ok : RangeOK S N 28760 28860 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00379

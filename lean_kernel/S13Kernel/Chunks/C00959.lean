import S13Kernel.Data.Keys

/-! Keys number 83702 to 83820. `data/c/c00959.txt` has sha256 641b50e3907e926e63874b8fd9bd25d6ee49f7a901fd72095977f0c6bd26b083. -/

namespace S13K.Chunks.C00959

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00959.txt"

theorem chk : chkChunk S N 83702 119 ces = true := by decide +kernel

theorem ok : RangeOK S N 83702 83821 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00959

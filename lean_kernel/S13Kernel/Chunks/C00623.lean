import S13Kernel.Data.Keys

/-! Keys number 50714 to 50802. `data/c/c00623.txt` has sha256 1791108494455988d08e7657c1544a9e9515eb82e7327dac64fe26cff86003ea. -/

namespace S13K.Chunks.C00623

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00623.txt"

theorem chk : chkChunk S N 50714 89 ces = true := by decide +kernel

theorem ok : RangeOK S N 50714 50803 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00623

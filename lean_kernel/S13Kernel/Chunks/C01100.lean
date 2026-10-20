import S13Kernel.Data.Keys

/-! Keys number 99486 to 99614. `data/c/c01100.txt` has sha256 d8cf25812db85b1f5199c7d328170ad37aea3593036cacbfec37f20725e7fac5. -/

namespace S13K.Chunks.C01100

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01100.txt"

theorem chk : chkChunk S N 99486 129 ces = true := by decide +kernel

theorem ok : RangeOK S N 99486 99615 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01100

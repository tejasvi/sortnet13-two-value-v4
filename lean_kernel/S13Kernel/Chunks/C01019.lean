import S13Kernel.Data.Keys

/-! Keys number 90168 to 90272. `data/c/c01019.txt` has sha256 1b26b844fa93074119648323def0c07452260166958979184162ff2e20713614. -/

namespace S13K.Chunks.C01019

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01019.txt"

theorem chk : chkChunk S N 90168 105 ces = true := by decide +kernel

theorem ok : RangeOK S N 90168 90273 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01019

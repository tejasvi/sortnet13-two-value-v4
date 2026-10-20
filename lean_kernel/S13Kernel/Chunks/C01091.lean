import S13Kernel.Data.Keys

/-! Keys number 98360 to 98482. `data/c/c01091.txt` has sha256 cc96a67c17a7dfa4d39d56b275a2dee4a0e31527b2af481a4890f90d49777268. -/

namespace S13K.Chunks.C01091

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01091.txt"

theorem chk : chkChunk S N 98360 123 ces = true := by decide +kernel

theorem ok : RangeOK S N 98360 98483 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01091

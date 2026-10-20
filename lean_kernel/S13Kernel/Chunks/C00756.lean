import S13Kernel.Data.Keys

/-! Keys number 63487 to 63592. `data/c/c00756.txt` has sha256 c4effd346efefbf16029f252d4d27e843e60c9e283b1f2d6353def0c1253e6db. -/

namespace S13K.Chunks.C00756

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00756.txt"

theorem chk : chkChunk S N 63487 106 ces = true := by decide +kernel

theorem ok : RangeOK S N 63487 63593 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00756

import S13Kernel.Data.Keys

/-! Keys number 32439 to 32528. `data/c/c00419.txt` has sha256 74f4a2b311f6a5de720906e4267715aaefec25faa17957c2264eaeffb9232855. -/

namespace S13K.Chunks.C00419

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00419.txt"

theorem chk : chkChunk S N 32439 90 ces = true := by decide +kernel

theorem ok : RangeOK S N 32439 32529 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00419

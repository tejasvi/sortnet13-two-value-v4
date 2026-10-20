import S13Kernel.Data.Keys

/-! Keys number 2566 to 2620. `data/c/c00049.txt` has sha256 71b0530bf5c4e81163fe2486a65447df000093d7f788a6bea5b0e673b8d0a710. -/

namespace S13K.Chunks.C00049

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00049.txt"

theorem chk : chkChunk S N 2566 55 ces = true := by decide +kernel

theorem ok : RangeOK S N 2566 2621 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00049

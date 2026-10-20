import S13Kernel.Data.Keys

/-! Keys number 40224 to 40308. `data/c/c00509.txt` has sha256 9cde1a0d99b75c2565d3b02552044dce29dd6882855b84134e916f5e0180428d. -/

namespace S13K.Chunks.C00509

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00509.txt"

theorem chk : chkChunk S N 40224 85 ces = true := by decide +kernel

theorem ok : RangeOK S N 40224 40309 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00509

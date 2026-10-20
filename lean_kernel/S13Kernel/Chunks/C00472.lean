import S13Kernel.Data.Keys

/-! Keys number 36840 to 36915. `data/c/c00472.txt` has sha256 0a95041e3b4107c9942f714095ab77730f0bb1f6632a7e6a25775dfe4d6aecc8. -/

namespace S13K.Chunks.C00472

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00472.txt"

theorem chk : chkChunk S N 36840 76 ces = true := by decide +kernel

theorem ok : RangeOK S N 36840 36916 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00472

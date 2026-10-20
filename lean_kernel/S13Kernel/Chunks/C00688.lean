import S13Kernel.Data.Keys

/-! Keys number 56776 to 56868. `data/c/c00688.txt` has sha256 37b5c7bef5f4ad0a4934e691e574c54c8636842a94402dac23400a9ccb380ce6. -/

namespace S13K.Chunks.C00688

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00688.txt"

theorem chk : chkChunk S N 56776 93 ces = true := by decide +kernel

theorem ok : RangeOK S N 56776 56869 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00688

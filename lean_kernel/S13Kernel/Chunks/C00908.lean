import S13Kernel.Data.Keys

/-! Keys number 78492 to 78595. `data/c/c00908.txt` has sha256 4f1a9fd9814934981b1de2cf33556fa9a9f08736f171d2dbf0ca5f55d2812540. -/

namespace S13K.Chunks.C00908

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00908.txt"

theorem chk : chkChunk S N 78492 104 ces = true := by decide +kernel

theorem ok : RangeOK S N 78492 78596 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00908

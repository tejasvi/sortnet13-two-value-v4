import S13Kernel.Data.Keys

/-! Keys number 18283 to 18370. `data/c/c00255.txt` has sha256 c1bb057b96592c76a5f3785b202722a2e77b86afa40af7b0792e18a489984ce2. -/

namespace S13K.Chunks.C00255

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00255.txt"

theorem chk : chkChunk S N 18283 88 ces = true := by decide +kernel

theorem ok : RangeOK S N 18283 18371 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00255

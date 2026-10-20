import S13Kernel.Data.Keys

/-! Keys number 49369 to 49452. `data/c/c00607.txt` has sha256 f9b68b245e9ed96a7a3a9ba59dd325973ee0b79b5e54091d4da28b2981ae9ade. -/

namespace S13K.Chunks.C00607

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00607.txt"

theorem chk : chkChunk S N 49369 84 ces = true := by decide +kernel

theorem ok : RangeOK S N 49369 49453 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00607

import S13Kernel.Data.Keys

/-! Keys number 26750 to 26819. `data/c/c00357.txt` has sha256 45e348f3dc4d0b87e7f9a48a0e98d6c5b7349cc3550e1383e487d414f0d9403a. -/

namespace S13K.Chunks.C00357

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00357.txt"

theorem chk : chkChunk S N 26750 70 ces = true := by decide +kernel

theorem ok : RangeOK S N 26750 26820 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00357

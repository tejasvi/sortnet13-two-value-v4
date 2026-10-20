import S13Kernel.Data.Keys

/-! Keys number 52056 to 52159. `data/c/c00638.txt` has sha256 26b2fc237393de3b0b25b6671a06f5772c4d4bf619e1d2bc9d62e92cd6a1663b. -/

namespace S13K.Chunks.C00638

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00638.txt"

theorem chk : chkChunk S N 52056 104 ces = true := by decide +kernel

theorem ok : RangeOK S N 52056 52160 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00638

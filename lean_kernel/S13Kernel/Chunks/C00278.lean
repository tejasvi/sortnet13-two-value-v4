import S13Kernel.Data.Keys

/-! Keys number 20143 to 20215. `data/c/c00278.txt` has sha256 bde2541e606f9a71ad1995c5fb842f9a7c9cb6872b7bdb07546a238baa548be2. -/

namespace S13K.Chunks.C00278

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00278.txt"

theorem chk : chkChunk S N 20143 73 ces = true := by decide +kernel

theorem ok : RangeOK S N 20143 20216 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00278

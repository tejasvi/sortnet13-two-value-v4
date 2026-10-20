import S13Kernel.Data.Keys

/-! Keys number 34639 to 34714. `data/c/c00447.txt` has sha256 d15a88ea52949234145b2dc58a8bc49f18dce442817a8023657d4e7696f4e2e4. -/

namespace S13K.Chunks.C00447

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00447.txt"

theorem chk : chkChunk S N 34639 76 ces = true := by decide +kernel

theorem ok : RangeOK S N 34639 34715 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00447

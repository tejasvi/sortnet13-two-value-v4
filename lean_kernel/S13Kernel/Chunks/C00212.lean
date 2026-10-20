import S13Kernel.Data.Keys

/-! Keys number 14548 to 14626. `data/c/c00212.txt` has sha256 1ba8aa4103ebf8ed02cec072cc34869ba50ceda821555a96e323e491a3b1b028. -/

namespace S13K.Chunks.C00212

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00212.txt"

theorem chk : chkChunk S N 14548 79 ces = true := by decide +kernel

theorem ok : RangeOK S N 14548 14627 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00212

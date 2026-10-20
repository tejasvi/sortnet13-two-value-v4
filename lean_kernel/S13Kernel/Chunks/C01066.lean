import S13Kernel.Data.Keys

/-! Keys number 95388 to 95503. `data/c/c01066.txt` has sha256 18940c0607016d1923634904673516425f3f18eed404b1384cf8e80f596c42a2. -/

namespace S13K.Chunks.C01066

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01066.txt"

theorem chk : chkChunk S N 95388 116 ces = true := by decide +kernel

theorem ok : RangeOK S N 95388 95504 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01066

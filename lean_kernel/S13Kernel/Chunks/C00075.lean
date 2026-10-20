import S13Kernel.Data.Keys

/-! Keys number 4324 to 4406. `data/c/c00075.txt` has sha256 545dbfa37881e1828c5830ed4d607a0b1b70ff5512d6125a137bbb250349509b. -/

namespace S13K.Chunks.C00075

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00075.txt"

theorem chk : chkChunk S N 4324 83 ces = true := by decide +kernel

theorem ok : RangeOK S N 4324 4407 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00075

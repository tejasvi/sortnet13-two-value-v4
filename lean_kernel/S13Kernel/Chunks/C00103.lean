import S13Kernel.Data.Keys

/-! Keys number 6145 to 6231. `data/c/c00103.txt` has sha256 cdda697fb6cef15719a0251196ba1b6aa11de1d3cce2a96d2f281f22d0bbcc0b. -/

namespace S13K.Chunks.C00103

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00103.txt"

theorem chk : chkChunk S N 6145 87 ces = true := by decide +kernel

theorem ok : RangeOK S N 6145 6232 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00103

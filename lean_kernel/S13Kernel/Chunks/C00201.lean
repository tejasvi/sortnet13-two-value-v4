import S13Kernel.Data.Keys

/-! Keys number 13688 to 13773. `data/c/c00201.txt` has sha256 ba876283dc091c2936d518f52ec88cce5572e3e31a429863bb5047ad4533188d. -/

namespace S13K.Chunks.C00201

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00201.txt"

theorem chk : chkChunk S N 13688 86 ces = true := by decide +kernel

theorem ok : RangeOK S N 13688 13774 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00201

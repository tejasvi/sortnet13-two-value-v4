import S13Kernel.Data.Keys

/-! Keys number 27540 to 27642. `data/c/c00366.txt` has sha256 0e7221d5f290fb201a48238d1ab984017cd9547c439d38df6a6dfdb9e6076811. -/

namespace S13K.Chunks.C00366

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00366.txt"

theorem chk : chkChunk S N 27540 103 ces = true := by decide +kernel

theorem ok : RangeOK S N 27540 27643 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00366

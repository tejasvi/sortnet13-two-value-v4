import S13Kernel.Data.Keys

/-! Keys number 55466 to 55551. `data/c/c00673.txt` has sha256 bc42eba29178d1f735e05e20476a9504bf9ca7a37a03f067894c85ba0efb3aed. -/

namespace S13K.Chunks.C00673

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00673.txt"

theorem chk : chkChunk S N 55466 86 ces = true := by decide +kernel

theorem ok : RangeOK S N 55466 55552 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00673

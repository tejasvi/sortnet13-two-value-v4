import S13Kernel.Data.Keys

/-! Keys number 62741 to 62833. `data/c/c00748.txt` has sha256 fc4a6f96017631a4c055b8143fccf4c641740d5e8377b8f0e8bef19f2962687e. -/

namespace S13K.Chunks.C00748

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00748.txt"

theorem chk : chkChunk S N 62741 93 ces = true := by decide +kernel

theorem ok : RangeOK S N 62741 62834 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00748

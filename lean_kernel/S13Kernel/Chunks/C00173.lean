import S13Kernel.Data.Keys

/-! Keys number 11422 to 11497. `data/c/c00173.txt` has sha256 761a4b2827bbd46c402749dccc42c7096a9e020f9872c46583f99b7ad010f7fe. -/

namespace S13K.Chunks.C00173

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00173.txt"

theorem chk : chkChunk S N 11422 76 ces = true := by decide +kernel

theorem ok : RangeOK S N 11422 11498 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00173
